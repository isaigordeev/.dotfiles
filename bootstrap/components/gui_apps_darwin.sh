#!/usr/bin/env bash
# Component: GUI apps via Homebrew cask (Darwin only)

install_gui_apps_darwin() {
    echo "[STEP] Installing GUI apps..."

    brew install --cask visual-studio-code || echo "[SKIP] VSCode already installed or failed"
    brew install --cask hyper || echo "[SKIP] Hyper already installed or failed"

    echo "[OK] GUI apps installed"
}
