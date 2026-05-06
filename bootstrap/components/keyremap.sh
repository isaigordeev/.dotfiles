#!/usr/bin/env bash
# Component: Keyboard remap (Right Command -> Return)
# Requires: DOTFILES_DIR to be set

install_keyremap_darwin() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    local src="$dotfiles_dir/macos/keyremap/com.local.KeyRemap.plist"
    local dst_dir="$HOME/Library/LaunchAgents"
    local dst="$dst_dir/com.local.KeyRemap.plist"

    echo "[STEP] Installing keyboard remap LaunchAgent..."

    if [ ! -f "$src" ]; then
        echo "[SKIP] $src not found"
        return
    fi

    mkdir -p "$dst_dir"
    ln -sf "$src" "$dst"
    echo "[OK] Linked com.local.KeyRemap.plist"

    local domain="gui/$(id -u)"
    launchctl bootout "$domain/com.local.KeyRemap" 2>/dev/null || true
    if launchctl bootstrap "$domain" "$dst" 2>/dev/null; then
        echo "[OK] LaunchAgent loaded"
    else
        echo "[WARN] Could not load LaunchAgent (will run on next login)"
    fi
}
