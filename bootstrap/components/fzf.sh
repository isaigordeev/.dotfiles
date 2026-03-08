#!/usr/bin/env bash
# Component: fzf keybindings (shared)

install_fzf_darwin() {
    echo "[STEP] Installing fzf keybindings..."

    if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
        "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
        echo "[OK] fzf keybindings installed"
    else
        echo "[SKIP] fzf install script not found"
    fi
}

install_fzf_linux() {
    echo "[STEP] Setting up fzf keybindings..."

    if [ ! -d "$HOME/.fzf" ]; then
        echo "[INFO] Installing fzf from source..."
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish || echo "[WARN] fzf install had issues"
        echo "[OK] fzf installed from source"
    else
        echo "[SKIP] fzf already installed"
    fi
}
