#!/usr/bin/env bash
# Component: Oh My Zsh (shared)

install_ohmyzsh() {
    echo "[STEP] Installing Oh My Zsh..."

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        echo "[OK] Oh My Zsh installed"
    else
        echo "[SKIP] Oh My Zsh already installed"
    fi
}
