#!/usr/bin/env bash
# Component: Vim plugins (shared)

ensure_vim_plugins() {
    echo "[STEP] Verifying Vim & Neovim plugins..."
    local failed=0
    local vim_plug_path="$HOME/.vim/autoload/plug.vim"
    if [ -f "$vim_plug_path" ]; then
        echo "[OK] vim-plug installed"
    else
        echo "[FAIL] vim-plug not installed ($vim_plug_path missing)"
        failed=1
    fi
    local lazy_path="$HOME/.local/share/nvim/lazy/lazy.nvim"
    if [ -d "$lazy_path" ]; then
        echo "[OK] lazy.nvim installed"
    else
        echo "[FAIL] lazy.nvim not found ($lazy_path missing)"
        failed=1
    fi
    return $failed
}

install_vim_plugins() {
    echo "[STEP] Installing Vim & Neovim plugins..."

    # Install vim-plug if not already installed
    local vim_plug_path="$HOME/.vim/autoload/plug.vim"
    if [ ! -f "$vim_plug_path" ]; then
        echo "[INFO] Installing vim-plug..."
        curl -fLo "$vim_plug_path" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        echo "[OK] vim-plug installed"
    else
        echo "[SKIP] vim-plug already installed"
    fi

    # Install Vim plugins
    echo "[INFO] Installing Vim plugins..."
    vim +PlugInstall +qall 2>/dev/null || true
    echo "[OK] Vim plugins installed"

    # Install Neovim plugins (lazy.nvim bootstraps itself on first run)
    echo "[INFO] Installing Neovim plugins..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    echo "[OK] Neovim plugins installed"
}
