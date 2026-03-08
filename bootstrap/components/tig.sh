#!/usr/bin/env bash
# Component: Tig config (shared)
# Requires: DOTFILES_DIR to be set

link_tig() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"

    echo "[STEP] Setting up tig..."

    if [ -f "$dotfiles_dir/tig/.tigrc" ]; then
        ln -sf "$dotfiles_dir/tig/.tigrc" "$HOME/.tigrc"
        echo "[OK] Linked .tigrc"
    else
        echo "[SKIP] tig/.tigrc not found"
    fi
}
