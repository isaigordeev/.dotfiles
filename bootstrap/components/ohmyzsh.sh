#!/usr/bin/env bash
# Component: Oh My Zsh (shared)

ensure_ohmyzsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "[OK] Oh My Zsh installed"
    else
        echo "[FAIL] Oh My Zsh not installed (~/.oh-my-zsh missing)"
        return 1
    fi
}

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
