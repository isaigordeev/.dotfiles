#!/bin/bash
# Toggle themes for Vim, Zsh, and Hyper (macOS)

VIMRC="$HOME/.vimrc"
NVIM_INIT="$HOME/.config/nvim/init.lua"
ZSHRC="$HOME/.zshrc"
HYPER="$HOME/.hyper.js"

# Resolve symlinks
REAL_VIMRC="$(readlink "$VIMRC" || echo "$VIMRC")"
REAL_NVIM="$(readlink "$NVIM_INIT" || echo "$NVIM_INIT")"
REAL_ZSHRC="$(readlink "$ZSHRC" || echo "$ZSHRC")"
REAL_HYPER="$(readlink "$HYPER" || echo "$HYPER")"

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

# --- Zsh: toggle SOBOLE_THEME_MODE ---
if grep -q "SOBOLE_THEME_MODE=light" "$REAL_ZSHRC"; then
    sed -i '' 's/SOBOLE_THEME_MODE=light/SOBOLE_THEME_MODE=dark/' "$REAL_ZSHRC"
    STATUS+="Zsh: dark\n"
else
    sed -i '' 's/SOBOLE_THEME_MODE=dark/SOBOLE_THEME_MODE=light/' "$REAL_ZSHRC"
    STATUS+="Zsh: light\n"
fi

# --- Hyper: toggle comment on localPlugins ---
if grep -q '^[[:space:]]*localPlugins:[[:space:]]*\["light"\],' "$REAL_HYPER"; then
    sed -i '' 's/^[[:space:]]*localPlugins:[[:space:]]*\["light"\],/\/\/ localPlugins: ["light"],/' "$REAL_HYPER"
    STATUS+="Hyper: dark\n"
elif grep -q '^[[:space:]]*\/\/ localPlugins:[[:space:]]*\["light"\],' "$REAL_HYPER"; then
    sed -i '' 's/^[[:space:]]*\/\/ localPlugins:[[:space:]]*\["light"\],/localPlugins: ["light"],/' "$REAL_HYPER"
    STATUS+="Hyper: light\n"
else
    STATUS+="Hyper: localPlugins not found\n"
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
              .oooooooooo
             .ooooooooooo
            .oooooooooooo
           .ooooooooooooo
          .oooooooooooo
         .ooooooooooo
        .oooooooooo
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

                    D A R K

EOF
else
    cat << 'EOF'


               \      |      /
                 \    |    /
                   \  |  /
            _  _  _  _|_  _  _  _
        -- ' .'.'.'.'|'.'.'.'.' --
           '.'.'.'.'.|.'.'.'.'.'
       \   .'.'.'.'.'|'.'.'.'.'   /
        \ '.'.'.'.'.'|'.'.'.'.'  /
    -----.'.'.'.'.'.'|'.'.'.'.'-----
         '.'.'.'.'.'.|.'.'.'.'.'
        / '.'.'.'.'.'|'.'.'.'.'. \
       /   '.'.'.'.'.|.'.'.'.'.'  \
           '.'.'.'.'.|.'.'.'.'.'
        --  '.'.'.'.'|'.'.'.'.' --
            ~  ~  ~  |  ~  ~  ~
                   /  |  \
                 /    |    \
               /      |      \

                   L I G H T

EOF
fi

echo -e "$STATUS"
