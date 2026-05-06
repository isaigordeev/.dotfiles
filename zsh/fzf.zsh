# fzf.vim analogs for zsh
#   frg   (Alt-A)  — :Rg   rg once, fuzzy-filter results
#   frgl  (Alt-a)  — :RG   live ripgrep (re-runs on each keystroke)
#   fline          — :BLines analog over stdin (piped only)

_fzf_preview='cat {1} 2>/dev/null | sed -n "$(({2}>5?{2}-5:1)),$(({2}+20))p"'

frg() {
   local out
   out=$(rg --column --line-number --no-heading --color=always --smart-case '' 2>/dev/null \
      | fzf --ansi --delimiter=: \
            --query "${1:-}" \
            --preview "$_fzf_preview" \
            --preview-window 'right:60%') || return
   local file line
   IFS=: read -r file line _ <<< "$out"
   [[ -n $file ]] && "${EDITOR:-nvim}" "+${line}" "$file"
}

frgl() {
   local rg_cmd='rg --column --line-number --no-heading --color=always --smart-case'
   local out
   out=$(FZF_DEFAULT_COMMAND="$rg_cmd ''" \
      fzf --ansi --disabled --delimiter=: \
          --query "${1:-}" \
          --bind "change:reload:sleep 0.1; $rg_cmd -- {q} || true" \
          --preview "$_fzf_preview" \
          --preview-window 'right:60%') || return
   local file line
   IFS=: read -r file line _ <<< "$out"
   [[ -n $file ]] && "${EDITOR:-nvim}" "+${line}" "$file"
}

fline() {
   local print_only=0
   while [[ $1 == -* ]]; do
      case $1 in
         -p|--print) print_only=1; shift ;;
         --) shift; break ;;
         *) break ;;
      esac
   done
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

# Keybindings — Alt-A / Alt-a (no widget for fline; it's pipe-driven)
_frg_widget()  { frg  </dev/tty >/dev/tty; zle reset-prompt }
_frgl_widget() { frgl </dev/tty >/dev/tty; zle reset-prompt }
zle -N _frg_widget
zle -N _frgl_widget
bindkey '^[A' _frg_widget
bindkey '^[a' _frgl_widget
