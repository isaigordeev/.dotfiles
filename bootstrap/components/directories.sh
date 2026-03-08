#!/usr/bin/env bash
# Component: Create directories (shared)

create_directories() {
    echo "[STEP] Creating required directories..."

    mkdir -p "$HOME/.vim/colors"
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.oh-my-zsh/custom/themes"

    echo "[OK] Directories created"
}
