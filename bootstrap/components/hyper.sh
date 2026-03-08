#!/usr/bin/env bash
# Component: Hyper terminal config (shared)
# Requires: DOTFILES_DIR to be set

link_hyper() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"

    echo "[STEP] Setting up Hyper..."

    if [ -f "$dotfiles_dir/hyper/.hyper.js" ]; then
        ln -sf "$dotfiles_dir/hyper/.hyper.js" "$HOME/.hyper.js"
        echo "[OK] Linked .hyper.js"
    else
        echo "[SKIP] hyper/.hyper.js not found"
    fi
}
