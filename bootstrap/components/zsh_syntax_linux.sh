#!/usr/bin/env bash
# Component: zsh-syntax-highlighting (Linux only - Darwin uses homebrew)

ensure_zsh_syntax_linux() {
    local zsh_syntax_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    echo "[STEP] Verifying zsh-syntax-highlighting..."
    if [ -d "$zsh_syntax_dir" ]; then
        echo "[OK] zsh-syntax-highlighting installed"
    else
        echo "[FAIL] zsh-syntax-highlighting not installed ($zsh_syntax_dir missing)"
        return 1
    fi
}

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
