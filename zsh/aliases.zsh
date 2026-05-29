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

# Open today's daily note (create with header if it doesn't exist yet)
daily() {
   local f="$(date +'%Y-%m-%d').md"
   local dir="$PALACE_DIR/notes/management/daily/$(date +'%Y')/$(date +'%m')"
   mkdir -p "$dir"
   local path="$dir/$f"
   if [ ! -s "$path" ]; then
      cat > "$path" <<EOF
$(date +'%a %d %b %Y at %H:%M:%S')

[[daily]]
EOF
   fi
   ${EDITOR:-nvim} "$path"
}

# Open a timestamped "shot" note (one file per call, named YYYY-MM-DD~HH.MM.md)
shot() {
   local f="$(date +'%Y-%m-%dT%H.%M').md"
   local dir="$PALACE_DIR/notes/management/daily/$(date +'%Y')/$(date +'%m')"
   mkdir -p "$dir"
   local path="$dir/$f"
   if [ ! -s "$path" ]; then
      cat > "$path" <<EOF
$(date +'%a %d %b %Y at %H:%M:%S')

[[shots]]
EOF
   fi
   ${EDITOR:-nvim} "$path"
}
