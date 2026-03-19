#!/usr/bin/env bash
# Component: Package installation (Darwin)

install_packages_darwin() {
    echo "[STEP] Installing required packages..."

    # Update Homebrew (ignore errors from broken casks)
    brew update || echo "[WARN] brew update had warnings, continuing..."

    # Install packages
    brew install zsh git curl vim neovim fzf ripgrep
    brew install zsh-syntax-highlighting
    brew install protobuf bear fd

    echo "[OK] Packages installed"
}
