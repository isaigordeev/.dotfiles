#!/usr/bin/env bash
# Component: VSCode settings and snippets (Darwin only)
# Requires: DOTFILES_DIR to be set

link_vscode_darwin() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    local vscode_dir="$HOME/Library/Application Support/Code/User"

    echo "[STEP] Setting up VSCode..."

    mkdir -p "$vscode_dir/snippets"

    if [ -f "$dotfiles_dir/vscode/settings.json" ]; then
        ln -sf "$dotfiles_dir/vscode/settings.json" "$vscode_dir/settings.json"
        echo "[OK] Linked VSCode settings.json"
    fi

    if [ -f "$dotfiles_dir/vscode/author.code-snippets" ]; then
        ln -sf "$dotfiles_dir/vscode/author.code-snippets" "$vscode_dir/snippets/author.code-snippets"
        echo "[OK] Linked author.code-snippets"
    fi

    if [ -f "$dotfiles_dir/vscode/python-author.code-snippets" ]; then
        ln -sf "$dotfiles_dir/vscode/python-author.code-snippets" "$vscode_dir/snippets/python-author.code-snippets"
        echo "[OK] Linked python-author.code-snippets"
    fi
}

link_vscode_linux() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    local vscode_dir="$HOME/.config/Code/User"

    echo "[STEP] Setting up VSCode..."

    mkdir -p "$vscode_dir/snippets"

    if [ -f "$dotfiles_dir/vscode/settings.json" ]; then
        ln -sf "$dotfiles_dir/vscode/settings.json" "$vscode_dir/settings.json"
        echo "[OK] Linked VSCode settings.json"
    fi

    if [ -f "$dotfiles_dir/vscode/author.code-snippets" ]; then
        ln -sf "$dotfiles_dir/vscode/author.code-snippets" "$vscode_dir/snippets/author.code-snippets"
        echo "[OK] Linked author.code-snippets"
    fi

    if [ -f "$dotfiles_dir/vscode/python-author.code-snippets" ]; then
        ln -sf "$dotfiles_dir/vscode/python-author.code-snippets" "$vscode_dir/snippets/python-author.code-snippets"
        echo "[OK] Linked python-author.code-snippets"
    fi
}
