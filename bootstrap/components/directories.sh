#!/usr/bin/env bash
# Component: Create directories (shared)

ensure_directories() {
    echo "[STEP] Verifying required directories..."
    local failed=0
    local dirs=("$HOME/.vim/colors" "$HOME/.config" "$HOME/.oh-my-zsh/custom/themes")
    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            echo "[OK] $dir"
        else
            echo "[FAIL] $dir missing"
            failed=1
        fi
    done
    return $failed
}

create_directories() {
    echo "[STEP] Creating required directories..."

    mkdir -p "$HOME/.vim/colors"
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.oh-my-zsh/custom/themes"

    echo "[OK] Directories created"
}
