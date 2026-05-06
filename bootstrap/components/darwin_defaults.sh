#!/usr/bin/env bash
# Component: Darwin defaults (Dock, etc.)
# Requires: DOTFILES_DIR to be set

apply_darwin_defaults() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    local script="$dotfiles_dir/darwin/defaults.sh"

    echo "[STEP] Applying Darwin defaults..."

    if [ ! -f "$script" ]; then
        echo "[SKIP] $script not found"
        return
    fi

    bash "$script"
    echo "[OK] Darwin defaults applied"
}
