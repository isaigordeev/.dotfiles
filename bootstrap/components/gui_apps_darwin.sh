#!/usr/bin/env bash
# Component: GUI apps via Homebrew cask (Darwin only)

# Check if a cask app is installed (by app name in /Applications)
_app_installed() {
    [ -d "/Applications/$1.app" ]
}

install_gui_apps_darwin() {
    echo "[STEP] Installing GUI apps..."

    if _app_installed "Visual Studio Code"; then
        echo "[SKIP] VSCode already installed"
    else
        brew install --cask visual-studio-code || echo "[WARN] VSCode installation failed"
    fi

    if _app_installed "Hyper"; then
        echo "[SKIP] Hyper already installed"
    else
        brew install --cask hyper || echo "[WARN] Hyper installation failed"
    fi

    if _app_installed "Ghostty"; then
        echo "[SKIP] Ghostty already installed"
    else
        brew install --cask ghostty || echo "[WARN] Ghostty installation failed"
    fi

    if _app_installed "Homerow"; then
        echo "[SKIP] Homerow already installed"
    else
        brew install --cask homerow || echo "[WARN] Homerow installation failed"
    fi

    echo "[OK] GUI apps installed"
}
