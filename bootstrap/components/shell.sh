#!/usr/bin/env bash
# Component: Set default shell (shared)

ensure_default_shell_darwin() {
    echo "[STEP] Verifying default shell..."
    local brew_zsh
    brew_zsh="$(brew --prefix 2>/dev/null)/bin/zsh"
    if [ "$SHELL" = "$brew_zsh" ]; then
        echo "[OK] Default shell is Homebrew zsh ($brew_zsh)"
    else
        echo "[FAIL] Default shell is $SHELL (expected $brew_zsh)"
        return 1
    fi
}

ensure_default_shell_linux() {
    echo "[STEP] Verifying default shell..."
    local zsh_path
    zsh_path="$(which zsh 2>/dev/null)"
    if [ -n "$zsh_path" ] && [ "$SHELL" = "$zsh_path" ]; then
        echo "[OK] Default shell is zsh ($zsh_path)"
    else
        echo "[FAIL] Default shell is $SHELL (expected zsh at $zsh_path)"
        return 1
    fi
}

set_default_shell_darwin() {
    echo "[STEP] Setting Zsh as default shell..."

    local brew_zsh
    brew_zsh="$(brew --prefix)/bin/zsh"

    if [ "$SHELL" != "$brew_zsh" ]; then
        echo "[INFO] Current shell: $SHELL"

        # Add Homebrew zsh to /etc/shells if not present
        if ! grep -q "$brew_zsh" /etc/shells 2>/dev/null; then
            echo "[SUDO] Adding Homebrew zsh to /etc/shells..."
            if echo "$brew_zsh" | sudo tee -a /etc/shells > /dev/null 2>&1; then
                echo "[OK] Added Homebrew zsh to /etc/shells"
            else
                echo "[WARN] Could not add to /etc/shells (requires sudo)"
            fi
        fi

        # Try to change shell
        if chsh -s "$brew_zsh" 2>/dev/null; then
            echo "[OK] Default shell changed to Homebrew zsh"
        else
            echo "[WARN] Could not change default shell automatically"
            echo "[INFO] You can change it manually with:"
            echo "    sudo chsh -s $brew_zsh \$USER"
        fi
    else
        echo "[SKIP] Homebrew zsh is already the default shell"
    fi
}

set_default_shell_linux() {
    echo "[STEP] Setting Zsh as default shell..."

    local zsh_path
    zsh_path=$(which zsh 2>/dev/null)

    if [ -n "$zsh_path" ] && [ "$SHELL" != "$zsh_path" ]; then
        echo "[INFO] Current shell: $SHELL"

        # Add zsh to /etc/shells if not present
        if ! grep -q "$zsh_path" /etc/shells 2>/dev/null; then
            echo "[SUDO] Adding zsh to /etc/shells..."
            if echo "$zsh_path" | sudo tee -a /etc/shells > /dev/null 2>&1; then
                echo "[OK] Added zsh to /etc/shells"
            else
                echo "[WARN] Could not add to /etc/shells (requires sudo)"
            fi
        fi

        # Try to change shell
        if chsh -s "$zsh_path" 2>/dev/null; then
            echo "[OK] Default shell changed to zsh"
        else
            echo "[WARN] Could not change default shell automatically"
            echo "[INFO] You can change it manually with:"
            echo "    sudo chsh -s \$(which zsh) \$USER"
        fi
    else
        echo "[SKIP] Zsh is already the default shell"
    fi
}
