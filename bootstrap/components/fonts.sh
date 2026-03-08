#!/usr/bin/env bash
# Component: Fonts installation
# Requires: DOTFILES_DIR to be set

install_fonts_darwin() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"

    echo "[STEP] Installing fonts..."

    mkdir -p "$HOME/Library/Fonts"

    if [ -d "$dotfiles_dir/fonts" ]; then
        cp -n "$dotfiles_dir/fonts"/*.ttf "$HOME/Library/Fonts/" 2>/dev/null || true
        cp -n "$dotfiles_dir/fonts"/*.otf "$HOME/Library/Fonts/" 2>/dev/null || true
        echo "[OK] Fonts installed"
    else
        echo "[SKIP] fonts/ directory not found"
    fi
}

install_fonts_linux() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"

    echo "[STEP] Installing fonts..."

    mkdir -p "$HOME/.local/share/fonts"

    if [ -d "$dotfiles_dir/fonts" ]; then
        cp -n "$dotfiles_dir/fonts"/*.ttf "$HOME/.local/share/fonts/" 2>/dev/null || true
        cp -n "$dotfiles_dir/fonts"/*.otf "$HOME/.local/share/fonts/" 2>/dev/null || true
        fc-cache -f 2>/dev/null || true
        echo "[OK] Fonts installed"
    else
        echo "[SKIP] fonts/ directory not found"
    fi
}
