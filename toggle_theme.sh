#!/bin/bash
# Toggle themes for Vim, Zsh, and Hyper (macOS)

VIMRC="$HOME/.vimrc"
NVIM_INIT="$HOME/.config/nvim/init.lua"
ZSHRC="$HOME/.zshrc"
HYPER="$HOME/.hyper.js"
GHOSTTY="$HOME/.config/ghostty/config"
TMUX_CONF="$HOME/.tmux.conf"

# Resolve symlinks
REAL_VIMRC="$(readlink "$VIMRC" || echo "$VIMRC")"
REAL_NVIM="$(readlink "$NVIM_INIT" || echo "$NVIM_INIT")"
REAL_ZSHRC="$(readlink "$ZSHRC" || echo "$ZSHRC")"
REAL_HYPER="$(readlink "$HYPER" || echo "$HYPER")"
REAL_GHOSTTY="$(readlink "$GHOSTTY" || echo "$GHOSTTY")"
REAL_TMUX="$(readlink "$TMUX_CONF" || echo "$TMUX_CONF")"
# config is itself in a symlinked dir; resolve fully
[ -L "$REAL_GHOSTTY" ] || REAL_GHOSTTY="$(cd "$(dirname "$GHOSTTY")" && pwd -P)/$(basename "$GHOSTTY")"

# Track which mode we're switching to
MODE=""
STATUS=""

# --- Vim: toggle colorscheme ---
if grep -q "colorscheme vs_light" "$REAL_VIMRC"; then
    sed -i '' 's/colorscheme vs_light/colorscheme vs_dark/' "$REAL_VIMRC"
    STATUS+="Vim: vs_dark\n"
    MODE="dark"
else
    sed -i '' 's/colorscheme vs_dark/colorscheme vs_light/' "$REAL_VIMRC"
    STATUS+="Vim: vs_light\n"
    MODE="light"
fi

# --- Neovim: toggle colorscheme ---
if [ -f "$REAL_NVIM" ]; then
    if grep -q 'colorscheme vs_light' "$REAL_NVIM"; then
        sed -i '' 's/colorscheme vs_light/colorscheme vs_dark/' "$REAL_NVIM"
        STATUS+="Neovim: vs_dark\n"
    else
        sed -i '' 's/colorscheme vs_dark/colorscheme vs_light/' "$REAL_NVIM"
        STATUS+="Neovim: vs_light\n"
    fi
else
    STATUS+="Neovim: init.lua not found\n"
fi

# --- Zsh: toggle ISG_THEME_MODE ---
if grep -q "ISG_THEME_MODE=light" "$REAL_ZSHRC"; then
    sed -i '' 's/ISG_THEME_MODE=light/ISG_THEME_MODE=dark/' "$REAL_ZSHRC"
    STATUS+="Zsh: dark\n"
else
    sed -i '' 's/ISG_THEME_MODE=dark/ISG_THEME_MODE=light/' "$REAL_ZSHRC"
    STATUS+="Zsh: light\n"
fi

# --- Hyper: toggle comment on localPlugins ---
if grep -q '^[[:space:]]*localPlugins:[[:space:]]*\["light"\],' "$REAL_HYPER"; then
    sed -i '' 's/^[[:space:]]*localPlugins:[[:space:]]*\["light"\],/   \/\/ localPlugins: ["light"],/' "$REAL_HYPER"
    STATUS+="Hyper: dark\n"
elif grep -q '^[[:space:]]*\/\/ localPlugins:[[:space:]]*\["light"\],' "$REAL_HYPER"; then
    sed -i '' 's/^[[:space:]]*\/\/ localPlugins:[[:space:]]*\["light"\],/   localPlugins: ["light"],/' "$REAL_HYPER"
    STATUS+="Hyper: light\n"
else
    STATUS+="Hyper: localPlugins not found\n"
fi

# --- Ghostty: toggle theme (Catppuccin Latte <-> Mocha) + cursor + bg/fg ---
if [ -f "$REAL_GHOSTTY" ]; then
    if grep -q "^theme = Catppuccin Latte" "$REAL_GHOSTTY"; then
        sed -i '' 's/^theme = Catppuccin Latte/theme = Catppuccin Mocha/' "$REAL_GHOSTTY"
        sed -i '' 's/^background = F2F2F2/background = 2f2f2f/' "$REAL_GHOSTTY"
        sed -i '' 's/^foreground = 000000/foreground = D4D4D4/' "$REAL_GHOSTTY"
        sed -i '' 's/^cursor-color = 000000/cursor-color = ffffff/' "$REAL_GHOSTTY"
        sed -i '' 's/^cursor-text = ffffff/cursor-text = 000000/' "$REAL_GHOSTTY"
        STATUS+="Ghostty: dark\n"
    elif grep -q "^theme = Catppuccin Mocha" "$REAL_GHOSTTY"; then
        sed -i '' 's/^theme = Catppuccin Mocha/theme = Catppuccin Latte/' "$REAL_GHOSTTY"
        sed -i '' 's/^background = 2f2f2f/background = F2F2F2/' "$REAL_GHOSTTY"
        sed -i '' 's/^foreground = D4D4D4/foreground = 000000/' "$REAL_GHOSTTY"
        sed -i '' 's/^cursor-color = ffffff/cursor-color = 000000/' "$REAL_GHOSTTY"
        sed -i '' 's/^cursor-text = 000000/cursor-text = ffffff/' "$REAL_GHOSTTY"
        STATUS+="Ghostty: light\n"
    else
        STATUS+="Ghostty: theme line not found\n"
    fi
else
    STATUS+="Ghostty: config not found\n"
fi

# --- Tmux: toggle theme ---
if [ -f "$REAL_TMUX" ]; then
    if grep -q "^# theme=light" "$REAL_TMUX"; then
        # Light -> Dark
        sed -i '' 's/^# theme=light/# theme=dark/' "$REAL_TMUX"
        sed -i '' 's/status-style "bg=default,fg=#555555"/status-style "bg=default,fg=#999999"/' "$REAL_TMUX"
        sed -i '' 's/window-status-style "bg=default,fg=#777777"/window-status-style "bg=default,fg=#888888"/' "$REAL_TMUX"
        sed -i '' 's/window-status-current-style "bg=default,fg=#000000,bold"/window-status-current-style "bg=default,fg=#cccccc,bold"/' "$REAL_TMUX"
        sed -i '' 's/status-left-style "bg=default,fg=#555555"/status-left-style "bg=default,fg=#999999"/' "$REAL_TMUX"
        sed -i '' 's/status-right-style "bg=default,fg=#555555"/status-right-style "bg=default,fg=#999999"/' "$REAL_TMUX"
        sed -i '' 's/message-style "bg=default,fg=#333333"/message-style "bg=default,fg=#bbbbbb"/' "$REAL_TMUX"
        sed -i '' 's/pane-border-style "fg=#cccccc"/pane-border-style "fg=#444444"/' "$REAL_TMUX"
        sed -i '' 's/pane-active-border-style "fg=#888888"/pane-active-border-style "fg=#666666"/' "$REAL_TMUX"
        STATUS+="Tmux: dark\n"
    elif grep -q "^# theme=dark" "$REAL_TMUX"; then
        # Dark -> Light
        sed -i '' 's/^# theme=dark/# theme=light/' "$REAL_TMUX"
        sed -i '' 's/status-style "bg=default,fg=#999999"/status-style "bg=default,fg=#555555"/' "$REAL_TMUX"
        sed -i '' 's/window-status-style "bg=default,fg=#888888"/window-status-style "bg=default,fg=#777777"/' "$REAL_TMUX"
        sed -i '' 's/window-status-current-style "bg=default,fg=#cccccc,bold"/window-status-current-style "bg=default,fg=#000000,bold"/' "$REAL_TMUX"
        sed -i '' 's/status-left-style "bg=default,fg=#999999"/status-left-style "bg=default,fg=#555555"/' "$REAL_TMUX"
        sed -i '' 's/status-right-style "bg=default,fg=#999999"/status-right-style "bg=default,fg=#555555"/' "$REAL_TMUX"
        sed -i '' 's/message-style "bg=default,fg=#bbbbbb"/message-style "bg=default,fg=#333333"/' "$REAL_TMUX"
        sed -i '' 's/pane-border-style "fg=#444444"/pane-border-style "fg=#cccccc"/' "$REAL_TMUX"
        sed -i '' 's/pane-active-border-style "fg=#666666"/pane-active-border-style "fg=#888888"/' "$REAL_TMUX"
        STATUS+="Tmux: light\n"
    else
        STATUS+="Tmux: theme marker not found\n"
    fi
    # Reload tmux config if tmux is running
    tmux source-file "$TMUX_CONF" 2>/dev/null && STATUS+="Tmux: config reloaded\n"
else
    STATUS+="Tmux: config not found\n"
fi

# --- Display full screen icon ---
clear
if [ "$MODE" = "dark" ]; then
    cat << 'EOF'


                              .
                             .o
                            .oo
                           .ooo
                          .oooo
                         .ooooo
                        .oooooo
                       .ooooooo
                      .oooooooo
                     .ooooooooo
                    .oooooooo
                   .ooooooo
                  .oooooo
                 .ooooo
                .oooo
               .ooo
              .oo
             .o
            .

                    M U R K

EOF
else
    cat << 'EOF'


                 .     |     *
                  \    |    /
              `.   \   '   /   .'
                `. .-"""""-. .'
            "*-._ / .ooooo. \ _.-*"
                 | ooooooooo |
           ~-`-.-| ooooooooo |-.~-`~
                 | ooooooooo |
            _.-*" \ 'ooooo' / "*-._
                .' `-.....-' `.
              .'   /   '   \    *.
                  /    +    \
                 '     |     `


                    L U M A

EOF
fi

echo -e "$STATUS"
echo ""
date "+%a %d %b %Y at %H:%M:%S"
