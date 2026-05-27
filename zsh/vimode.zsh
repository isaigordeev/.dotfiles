# --- vi mode on the command line ---
bindkey -v
export KEYTIMEOUT=1     # 100ms ESC delay (default 400ms feels laggy)

# In normal mode: v or n opens $EDITOR on the current command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'n' edit-command-line

# Cursor shape per mode (block in normal, beam in insert)
function zle-keymap-select {
   case $KEYMAP in
      vicmd)      print -n '\e[2 q' ;;
      main|viins) print -n '\e[6 q' ;;
   esac
}
function zle-line-init { print -n '\e[6 q' }
zle -N zle-keymap-select
zle -N zle-line-init
