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

# Guard: PALACE_DIR may not exist (e.g. encrypted, not yet decrypted)
_palace_check() {
   if [ ! -d "$PALACE_DIR" ]; then
      echo "palace: '$PALACE_DIR' not found — decrypt it first" >&2
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

# Open a timestamped "shot" note (one file per call, named YYYY-MM-DD~HH.MM.md)
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
