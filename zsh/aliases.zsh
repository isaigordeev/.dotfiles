log() {
  local f="$HOME/logs/$(date +%Y%m%d-%H%M%S).log"
  mkdir -p "$HOME/logs"
  echo "logging to $f"
  script -q "$f"
}

alias n='nvim'
alias n.='nvim .'
nf() { local f; f=$(fzf) && nvim "$f"; }
alias t='tig'
alias ts='tig status'
alias v='vim'
alias v.='vim .'
