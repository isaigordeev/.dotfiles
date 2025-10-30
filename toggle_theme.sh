#!/bin/bash
# Toggle themes for Vim, Zsh, and Hyper (macOS)

VIMRC="$HOME/.vimrc"
ZSHRC="$HOME/.zshrc"
HYPER="$HOME/.hyper.js"

# Resolve symlinks
REAL_VIMRC="$(readlink "$VIMRC" || echo "$VIMRC")"
REAL_ZSHRC="$(readlink "$ZSHRC" || echo "$ZSHRC")"
REAL_HYPER="$(readlink "$HYPER" || echo "$HYPER")"

echo $REAL_VIMRC
echo $REAL_ZSHRC
echo $REAL_HYPER

# --- Vim: toggle colorscheme ---
if grep -q "colorscheme vs_light" "$REAL_VIMRC"; then
    sed -i '' 's/colorscheme vs_light/colorscheme vs_dark/' "$REAL_VIMRC"
    echo "🌙 Vim: vs_dark"
else
    sed -i '' 's/colorscheme vs_dark/colorscheme vs_light/' "$REAL_VIMRC"
    echo "☀️ Vim: vs_light"
fi

# --- Zsh: toggle SOBOLE_THEME_MODE ---
if grep -q "SOBOLE_THEME_MODE=light" "$REAL_ZSHRC"; then
    sed -i '' 's/SOBOLE_THEME_MODE=light/SOBOLE_THEME_MODE=dark/' "$REAL_ZSHRC"
    echo "🌙 Zsh: dark"
else
    sed -i '' 's/SOBOLE_THEME_MODE=dark/SOBOLE_THEME_MODE=light/' "$REAL_ZSHRC"
    echo "☀️ Zsh: light"
fi

# --- Hyper: toggle comment on localPlugins ---

# Comment the line (only if it is not already commented)
if grep -q '^[[:space:]]*localPlugins:[[:space:]]*\["light"\],' "$REAL_HYPER"; then
    sed -i '' 's/^[[:space:]]*localPlugins:[[:space:]]*\["light"\],/\/\/ localPlugins: ["light"],/' "$REAL_HYPER"
    echo "🌙 Hyper: commented"
# Uncomment the line (only if it starts with //)
elif grep -q '^[[:space:]]*\/\/ localPlugins:[[:space:]]*\["light"\],' "$REAL_HYPER"; then
    sed -i '' 's/^[[:space:]]*\/\/ localPlugins:[[:space:]]*\["light"\],/localPlugins: ["light"],/' "$REAL_HYPER"
    echo "☀️ Hyper: uncommented"
else
    echo "⚠️ Hyper: localPlugins line not found"
fi



echo "Theme toggled!"
