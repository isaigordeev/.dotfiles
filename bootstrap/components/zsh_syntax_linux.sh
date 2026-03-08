#!/usr/bin/env bash
# Component: zsh-syntax-highlighting (Linux only - Darwin uses homebrew)

install_zsh_syntax_linux() {
    echo "[STEP] Installing zsh-syntax-highlighting..."

    local zsh_syntax_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

    if [ ! -d "$zsh_syntax_dir" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_syntax_dir"
        echo "[OK] zsh-syntax-highlighting installed"
    else
        echo "[SKIP] zsh-syntax-highlighting already installed"
    fi
}
