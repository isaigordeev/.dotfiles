log() {
  local f="$HOME/logs/$(date +%Y%m%d-%H%M%S).log"
  mkdir -p "$HOME/logs"
  echo "logging to $f"
  script -q "$f"
}

alias n='nvim'
alias n.='nvim .'
np() { local f; f=$(fzf) && nvim "$f"; }
alias t='tig'
alias ts='tig status'
alias v='vim'
alias v.='vim .'
alias c='claude'

export PALACE_DIR="$HOME/palace/palace"

# Guard for palace functions. Checks in stages so error messages point at the
# real problem (wrapper dir missing vs palace missing vs not yet decrypted).
_palace_check() {
   local parent="${PALACE_DIR%/*}"
   if [ ! -d "$parent" ]; then
      echo "palace: parent '$parent' does not exist" >&2
      return 1
   fi
   if [ ! -d "$PALACE_DIR" ]; then
      echo "palace: '$PALACE_DIR' does not exist (palace itself missing)" >&2
      return 1
   fi
   if [ ! -d "$PALACE_DIR/notes" ]; then
      echo "palace: '$PALACE_DIR' not decrypted — no 'notes/' inside" >&2
      return 1
   fi
}

# Open today's daily note (create with header if it doesn't exist yet)
daily() {
   _palace_check || return 1
   local f="$(date +'%Y-%m-%d').md"
   local note_dir="$PALACE_DIR/notes/management/daily/$(date +'%Y')/$(date +'%m')"
   mkdir -p "$note_dir"
   local note="$note_dir/$f"
   if [ ! -s "$note" ]; then
      cat > "$note" <<EOF
$(date +'%a %d %b %Y at %H:%M:%S')

[[daily]]
EOF
   fi
   ( cd "$PALACE_DIR" && ${EDITOR:-nvim} "$note" )
}

# Open this ISO week's note (e.g. 2026-W22.md) under notes/management/weekly/
weekly() {
   _palace_check || return 1
   local f="$(date +'%G-W%V').md"
   local note_dir="$PALACE_DIR/notes/management/weekly"
   mkdir -p "$note_dir"
   local note="$note_dir/$f"
   if [ ! -s "$note" ]; then
      cat > "$note" <<EOF
$(date +'%a %d %b %Y at %H:%M:%S')

[[weekly]]
EOF
   fi
   ( cd "$PALACE_DIR" && ${EDITOR:-nvim} "$note" )
}

# tg [-l|-n]   manage murmur notes under notes/me/writing/murmur/
#   -l         fzf-pick an existing note and open it
#   -n         create a new note (default; prompts for a name)
tg() {
   _palace_check || return 1
   local note_dir="$PALACE_DIR/notes/me/writing/murmur"
   mkdir -p "$note_dir"

   case "$1" in
      -l)
         if command -v fzf > /dev/null 2>&1; then
            local pick
            pick=$(ls -1t "$note_dir" 2>/dev/null | fzf --prompt='murmur > ' --no-sort) || return 1
            [ -z "$pick" ] && return 1
            ( cd "$PALACE_DIR" && ${EDITOR:-nvim} "$note_dir/$pick" )
         else
            ls -1t "$note_dir"
         fi
         return 0
         ;;
      -n|"")
         local name
         read "name?murmur note name: "
         [ -z "$name" ] && { echo "tg: empty name" >&2; return 1; }
         local f="${name}"
         [[ "$f" != *.md ]] && f="${f}.md"
         local note="$note_dir/$f"
         if [ ! -s "$note" ]; then
            cat > "$note" <<EOF
$(date +'%a %d %b %Y at %H:%M:%S')

[[murmur]]
EOF
         fi
         ( cd "$PALACE_DIR" && ${EDITOR:-nvim} "$note" )
         ;;
      *)
         echo "usage: tg [-l|-n]" >&2
         return 1
         ;;
   esac
}

# Open a timestamped "shot" note (one file per call, named YYYY-MM-DDTHH.MM.md)
shot() {
   _palace_check || return 1
   local f="$(date +'%Y-%m-%dT%H.%M').md"
   local note_dir="$PALACE_DIR/notes/management/daily/$(date +'%Y')/$(date +'%m')"
   mkdir -p "$note_dir"
   local note="$note_dir/$f"
   if [ ! -s "$note" ]; then
      cat > "$note" <<EOF
$(date +'%a %d %b %Y at %H:%M:%S')

[[shots]]
EOF
   fi
   ( cd "$PALACE_DIR" && ${EDITOR:-nvim} "$note" )
}
