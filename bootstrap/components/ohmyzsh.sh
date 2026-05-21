#!/usr/bin/env bash
# Component: Oh My Zsh (shared)

install_ohmyzsh() {
    echo "[STEP] Installing Oh My Zsh..."

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        if sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
            echo "[OK] Oh My Zsh installed"
        else
            echo "[WARN] Oh My Zsh installation had issues, continuing..."
        fi
    else
        echo "[SKIP] Oh My Zsh already installed"
    fi
}
