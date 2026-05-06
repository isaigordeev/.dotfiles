# fzf.vim analogs for zsh
#   fp  — :Files  file picker
#   fA  — :Rg     rg once, fuzzy-filter results
#   fa  — :RG     live ripgrep (re-runs on each keystroke)
#   fC  — :BLines analog; default opens editor, -p prints

if command -v bat >/dev/null 2>&1; then
   _fzf_preview='bat --color=always --style=numbers --highlight-line {2} {1}'
   _fzf_file_preview='bat --color=always --style=numbers {}'
else
   _fzf_preview='awk -v n={2} "NR>=n-10 && NR<=n+40 {printf \"%5d  %s\n\", NR, \$0}" {1} 2>/dev/null'
   _fzf_file_preview='awk "NR<=200 {printf \"%5d  %s\n\", NR, \$0}" {} 2>/dev/null'
fi

fp() {
   local files
   files=("${(@f)$(fd --type f --hidden --follow --exclude .git "${1:-}" \
      | fzf --multi --ansi \
            --preview "$_fzf_file_preview" \
            --preview-window 'right:60%')}") || return
   [[ -n $files[1] ]] && "${EDITOR:-nvim}" "${files[@]}"
}

fA() {
   local out
   out=$(rg --column --line-number --no-heading --color=always --smart-case '' 2>/dev/null \
      | fzf --ansi --delimiter=: \
            --query "${1:-}" \
            --preview "$_fzf_preview" \
            --preview-window 'right:60%:+{2}-/2') || return
   local file line
   IFS=: read -r file line _ <<< "$out"
   [[ -n $file ]] && "${EDITOR:-nvim}" "+${line}" "$file"
}

fa() {
   local rg_cmd='rg --column --line-number --no-heading --color=always --smart-case'
   local out
   out=$(FZF_DEFAULT_COMMAND="$rg_cmd ''" \
      fzf --ansi --disabled --delimiter=: \
          --query "${1:-}" \
          --bind "change:reload:sleep 0.1; $rg_cmd -- {q} || true" \
          --preview "$_fzf_preview" \
          --preview-window 'right:60%:+{2}-/2') || return
   local file line
   IFS=: read -r file line _ <<< "$out"
   [[ -n $file ]] && "${EDITOR:-nvim}" "+${line}" "$file"
}

fC() {
   local print_only=0
   while [[ $1 == -* ]]; do
      case $1 in
         -p|--print) print_only=1; shift ;;
         --) shift; break ;;
         *) break ;;
      esac
   done

   # BLines mode: fC FILE → fuzzy-pick a line, open editor at it
   if [[ -f $1 ]]; then
      local file=$1
      local preview
      if command -v bat >/dev/null 2>&1; then
         preview="bat --color=always --style=numbers --highlight-line {1} ${(q)file}"
      else
         preview="awk -v n={1} 'NR>=n-10 && NR<=n+40 {printf \"%5d  %s\\n\", NR, \$0}' ${(q)file}"
      fi
      local pick
      pick=$(awk '{printf "%d:%s\n", NR, $0}' "$file" \
         | fzf --ansi --delimiter=: --with-nth=2.. \
               --no-sort --tiebreak=index --layout=reverse \
               --preview "$preview" \
               --preview-window "right:60%:+{1}-/2") || return
      local line=${pick%%:*}
      [[ -z $line ]] && return
      if (( print_only )); then
         print -r -- "$line"
      else
         "${EDITOR:-nvim}" "+${line}" "$file"
      fi
      return
   fi

   # Pipe mode: ... | fC
   local sel
   sel=$(fzf --ansi --no-sort --tiebreak=index --layout=reverse "$@") || return
   if (( print_only )); then
      print -r -- "$sel"
      return
   fi
   local file line rest
   IFS=: read -r file line rest <<< "$sel"
   if [[ -f $file && $line == <-> ]]; then
      "${EDITOR:-nvim}" "+${line}" "$file"
   elif [[ -f $sel ]]; then
      "${EDITOR:-nvim}" "$sel"
   else
      print -r -- "$sel"
   fi
}
