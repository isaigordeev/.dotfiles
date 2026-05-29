# --- vi mode on the command line ---
bindkey -v
export KEYTIMEOUT=1     # 100ms ESC delay (default 400ms feels laggy)

# In normal mode: v or n opens $EDITOR on the current command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'n' edit-command-line

# In normal mode: y yanks to ZLE CUTBUFFER AND copies to the system clipboard
function vi-yank-clipboard() {
   zle vi-yank
   printf "%s" "$CUTBUFFER" | pbcopy 2>/dev/null \
      || printf "%s" "$CUTBUFFER" | xclip -selection clipboard 2>/dev/null
}
zle -N vi-yank-clipboard
bindkey -M vicmd 'y' vi-yank-clipboard

# Unbind K (default = run-help → opens man page; sometimes leaves ZLE in a
# broken redraw state on return)
bindkey -M vicmd -r 'K'

# Cursor shape per mode + mode-aware isg prompt caret
# user:  » in normal, › in insert    root:  # in normal, @ in insert
VI_MODE=ins

# Override isg theme's caret to react to vi mode. Color rules mirror the original.
__isg::current_caret () {
   local color sign
   if [[ "$USER" == 'root' ]] || [[ "$(id -u "$USER")" == 0 ]]; then
      color='red'
      [[ $VI_MODE == ins ]] && sign='@' || sign='#'
   else
      [[ "$ISG_THEME_MODE" == 'dark' ]] && color='white' || color='black'
      [[ $VI_MODE == ins ]] && sign='›' || sign='»'
   fi
   echo "%{$fg[$color]%}$sign%{$reset_color%}"
}

function zle-keymap-select {
   case $KEYMAP in
      vicmd)      VI_MODE=cmd; print -n '\e[2 q' ;;
      main|viins) VI_MODE=ins; print -n '\e[6 q' ;;
   esac
   zle reset-prompt
}
function zle-line-init { VI_MODE=ins; print -n '\e[6 q' }
function zle-line-finish { print -n '\e[2 q' }
zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish
