#!/usr/bin/env bash
# Component: Package installation (Darwin)

install_packages_darwin() {
    echo "[STEP] Installing required packages..."

    # Update Homebrew (ignore errors from broken casks)
    brew update || echo "[WARN] brew update had warnings, continuing..."

    # Install packages (|| true to continue on link failures like MacVim conflicts)
    brew install zsh git curl vim neovim fzf ripgrep || true
    brew install zsh-syntax-highlighting || true
    brew install protobuf bear fd tokei || true
    brew install prettier || true

    echo "[OK] Packages installed"
}
