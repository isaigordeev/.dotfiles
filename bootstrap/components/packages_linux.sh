#!/usr/bin/env bash
# Component: Package installation (Linux)

detect_package_manager() {
    if command -v apt-get > /dev/null 2>&1; then
        echo "apt"
    elif command -v dnf > /dev/null 2>&1; then
        echo "dnf"
    elif command -v yum > /dev/null 2>&1; then
        echo "yum"
    elif command -v pacman > /dev/null 2>&1; then
        echo "pacman"
    elif command -v zypper > /dev/null 2>&1; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

install_packages_linux() {
    local pkg_manager
    pkg_manager=$(detect_package_manager)
    echo "[INFO] Detected package manager: $pkg_manager"
    echo "[STEP] Installing required packages..."

    case "$pkg_manager" in
        apt)
            sudo apt-get update || echo "[WARN] apt-get update had warnings, continuing..."
            sudo apt-get install -y zsh git curl vim neovim fzf ripgrep nodejs npm || echo "[WARN] Some packages may have failed"
            ;;
        dnf)
            sudo dnf install -y zsh git curl vim neovim fzf ripgrep nodejs npm || echo "[WARN] Some packages may have failed"
            ;;
        yum)
            sudo yum install -y zsh git curl vim neovim fzf nodejs npm || echo "[WARN] Some packages may have failed"
            ;;
        pacman)
            sudo pacman -Sy --noconfirm zsh git curl vim neovim fzf ripgrep nodejs npm || echo "[WARN] Some packages may have failed"
            ;;
        zypper)
            sudo zypper install -y zsh git curl vim neovim fzf ripgrep nodejs npm || echo "[WARN] Some packages may have failed"
            ;;
        *)
            echo "[WARN] Unknown package manager. Please install manually: zsh git curl vim neovim fzf ripgrep"
            ;;
    esac

    echo "[OK] Packages installed"
}
