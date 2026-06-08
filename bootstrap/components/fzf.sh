#!/usr/bin/env bash
# Component: fzf keybindings (shared)

ensure_fzf_darwin() {
    echo "[STEP] Verifying fzf keybindings..."
    if [ -f "$HOME/.fzf.zsh" ]; then
        echo "[OK] fzf keybindings installed (~/.fzf.zsh)"
    else
        echo "[FAIL] fzf keybindings not installed (~/.fzf.zsh missing)"
        return 1
    fi
}

ensure_fzf_linux() {
    echo "[STEP] Verifying fzf..."
    if [ -d "$HOME/.fzf" ]; then
        echo "[OK] fzf installed (~/.fzf)"
    else
        echo "[FAIL] fzf not installed (~/.fzf missing)"
        return 1
    fi
}

install_fzf_darwin() {
    echo "[STEP] Installing fzf keybindings..."

    local fzf_install
    fzf_install="$(brew --prefix 2>/dev/null)/opt/fzf/install"

    if [ -f "$fzf_install" ]; then
        if "$fzf_install" --key-bindings --completion --no-update-rc --no-bash --no-fish; then
            echo "[OK] fzf keybindings installed"
        else
            echo "[WARN] fzf keybindings had issues, continuing..."
        fi
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
