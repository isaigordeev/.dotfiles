#!/usr/bin/env bash
# Component: Package installation (Darwin)

install_packages_darwin() {
    echo "[STEP] Installing required packages..."

    # Update Homebrew (ignore errors from broken casks)
    brew update || echo "[WARN] brew update had warnings, continuing..."

    local brewfile="$DOTFILES_DIR/darwin/Brewfile"
    if [ ! -f "$brewfile" ]; then
        echo "[ERROR] Brewfile not found at $brewfile"
        return 1
    fi

    # || true so link/cask failures (e.g. MacVim conflicts) don't abort bootstrap
    brew bundle --file="$brewfile" || true

    echo "[OK] Packages installed"
}
