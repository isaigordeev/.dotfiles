#!/usr/bin/env bash
# Component: Link dotfiles (shared)
# Requires: DOTFILES_DIR to be set

link_dotfiles() {
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
    echo "[STEP] Linking dotfiles..."

    # Link Zsh config
    if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        echo "[BACKUP] Backing up existing .zshrc to .zshrc.backup"
        mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
    fi
    ln -sf "$dotfiles_dir/zsh/.zshrc" "$HOME/.zshrc"
    echo "[OK] Linked .zshrc"

    # Link Zsh theme
    ln -sf "$dotfiles_dir/zsh/sobole.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/sobole.zsh-theme"
    echo "[OK] Linked sobole.zsh-theme"

    # Link Vim config
    if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
        echo "[BACKUP] Backing up existing .vimrc to .vimrc.backup"
        mv "$HOME/.vimrc" "$HOME/.vimrc.backup"
    fi
    ln -sf "$dotfiles_dir/vim/.vimrc" "$HOME/.vimrc"
    echo "[OK] Linked .vimrc"

    # Link Tmux config
    if [ -f "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then
        echo "[BACKUP] Backing up existing .tmux.conf to .tmux.conf.backup"
        mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
    fi
    ln -sf "$dotfiles_dir/tmux/.tmux.conf" "$HOME/.tmux.conf"
    echo "[OK] Linked .tmux.conf"

    # Link Vim color schemes (skip if source and target are the same directory)
    local src_dir="$dotfiles_dir/vim/.vim/colors"
    local dst_dir="$HOME/.vim/colors"
    if [ "$(realpath "$src_dir")" != "$(realpath "$dst_dir")" ]; then
        for color_file in "$src_dir"/*.vim; do
            if [ -f "$color_file" ]; then
                ln -sf "$color_file" "$dst_dir/$(basename "$color_file")"
                echo "[OK] Linked $(basename "$color_file")"
            fi
        done
    else
        echo "[SKIP] Vim colors already in place (source and target are the same)"
    fi

    # Link Neovim config (skip if already pointing to the right place)
    local nvim_src="$dotfiles_dir/nvim"
    local nvim_dst="$HOME/.config/nvim"
    if [ "$(realpath "$nvim_src" 2>/dev/null)" != "$(realpath "$nvim_dst" 2>/dev/null)" ]; then
        if [ -d "$nvim_dst" ] && [ ! -L "$nvim_dst" ]; then
            echo "[BACKUP] Backing up existing nvim config to nvim.backup"
            mv "$nvim_dst" "$HOME/.config/nvim.backup"
        fi
        ln -sf "$nvim_src" "$nvim_dst"
        echo "[OK] Linked nvim config"
    else
        echo "[SKIP] Neovim config already in place (source and target are the same)"
    fi
}
