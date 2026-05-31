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

# Palace notes — functions live in the palace wrapper repo so they ship with
# palace itself. Only loaded if the file is present (palace is cloned).
export PALACE_DIR="$HOME/palace/palace"
[ -r "${PALACE_DIR%/*}/.zsh/palace.zsh" ] && source "${PALACE_DIR%/*}/.zsh/palace.zsh"
