#!/usr/bin/env bash
# Component: macOS defaults (Dock, etc.)
# Requires: DOTFILES_DIR to be set

apply_macos_defaults() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    local script="$dotfiles_dir/macos/defaults.sh"

    echo "[STEP] Applying macOS defaults..."

    if [ ! -f "$script" ]; then
        echo "[SKIP] $script not found"
        return
    fi

    bash "$script"
    echo "[OK] macOS defaults applied"
}
