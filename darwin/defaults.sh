#!/usr/bin/env bash
# Darwin defaults loader — sources every module in darwin/defaults/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/defaults"

if [ -d "$MODULES_DIR" ]; then
    for module in "$MODULES_DIR"/*.sh; do
        [ -f "$module" ] || continue
        echo "  [defaults] $(basename "$module" .sh)"
        # shellcheck disable=SC1090
        source "$module"
    done
fi

killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true
killall ControlCenter 2>/dev/null || true
