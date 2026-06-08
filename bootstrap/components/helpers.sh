#!/usr/bin/env bash
# Shared helpers for bootstrap components

# Verify that $link is a symlink resolving to $target.
# Prints [OK] or [FAIL] and returns 1 on failure.
_check_link() {
    local label="$1" link="$2" target="$3"
    if [ -L "$link" ] && [ "$(realpath "$link" 2>/dev/null)" = "$(realpath "$target" 2>/dev/null)" ]; then
        echo "[OK] Linked: $label"
    elif [ -L "$link" ]; then
        echo "[FAIL] Wrong link: $label -> $(readlink "$link") (expected -> $target)"
        return 1
    else
        echo "[FAIL] Not linked: $label ($link missing or not a symlink)"
        return 1
    fi
}
