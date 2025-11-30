#!/usr/bin/env bash
#
# Bootstrap script for Linux systems
# Sets up dotfiles: zsh, vim, and related configurations
#
set -e

DOTFILES_DIR="$HOME/.dotfiles"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================="
echo "  Dotfiles Bootstrap for Linux"
echo "=========================================="
echo ""

# ============================================================
#                    DETECT PACKAGE MANAGER
# ============================================================
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

PKG_MANAGER=$(detect_package_manager)
echo "[INFO] Detected package manager: $PKG_MANAGER"
echo ""

# ============================================================
#                    INSTALL PACKAGES
# ============================================================
echo "[STEP 1/6] Installing required packages..."

install_packages() {
    case "$PKG_MANAGER" in
        apt)
            sudo apt-get update
            sudo apt-get install -y zsh git curl vim fzf ripgrep
            ;;
        dnf)
            sudo dnf install -y zsh git curl vim fzf ripgrep
            ;;
        yum)
            sudo yum install -y zsh git curl vim fzf
            # ripgrep might need EPEL
            ;;
        pacman)
            sudo pacman -Sy --noconfirm zsh git curl vim fzf ripgrep
            ;;
        zypper)
            sudo zypper install -y zsh git curl vim fzf ripgrep
            ;;
        *)
            echo "[ERROR] Unknown package manager. Please install manually:"
            echo "  - zsh"
            echo "  - git"
            echo "  - curl"
            echo "  - vim"
            echo "  - fzf"
            echo "  - ripgrep (optional)"
            exit 1
            ;;
    esac
}

install_packages
echo "[OK] Packages installed"
echo ""

# ============================================================
#                    INSTALL OH MY ZSH
# ============================================================
echo "[STEP 2/6] Installing Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "[OK] Oh My Zsh installed"
else
    echo "[SKIP] Oh My Zsh already installed"
fi
echo ""

# ============================================================
#                    INSTALL ZSH SYNTAX HIGHLIGHTING
# ============================================================
echo "[STEP 3/6] Installing zsh-syntax-highlighting..."

ZSH_SYNTAX_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ ! -d "$ZSH_SYNTAX_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_SYNTAX_DIR"
    echo "[OK] zsh-syntax-highlighting installed"
else
    echo "[SKIP] zsh-syntax-highlighting already installed"
fi
echo ""

# ============================================================
#                    CREATE DIRECTORIES
# ============================================================
echo "[STEP 4/6] Creating required directories..."

mkdir -p "$HOME/.vim/colors"
mkdir -p "$HOME/.oh-my-zsh/custom/themes"
echo "[OK] Directories created"
echo ""

# ============================================================
#                    LINK DOTFILES
# ============================================================
echo "[STEP 5/6] Linking dotfiles..."

# Link Zsh config
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "[BACKUP] Backing up existing .zshrc to .zshrc.backup"
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi
ln -sf "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
echo "[OK] Linked .zshrc"

# Link Zsh theme
ln -sf "$SCRIPT_DIR/zsh/sobole.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/sobole.zsh-theme"
echo "[OK] Linked sobole.zsh-theme"

# Link Vim config
if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
    echo "[BACKUP] Backing up existing .vimrc to .vimrc.backup"
    mv "$HOME/.vimrc" "$HOME/.vimrc.backup"
fi
ln -sf "$SCRIPT_DIR/vim/.vimrc" "$HOME/.vimrc"
echo "[OK] Linked .vimrc"

# Link Vim color schemes
for color_file in "$SCRIPT_DIR/vim/.vim/colors"/*.vim; do
    if [ -f "$color_file" ]; then
        ln -sf "$color_file" "$HOME/.vim/colors/$(basename "$color_file")"
        echo "[OK] Linked $(basename "$color_file")"
    fi
done

echo ""

# ============================================================
#                    INSTALL VIM PLUGINS
# ============================================================
echo "[STEP 6/6] Installing Vim plugins..."

# Install vim-plug if not already installed
VIM_PLUG_PATH="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$VIM_PLUG_PATH" ]; then
    echo "[INFO] Installing vim-plug..."
    curl -fLo "$VIM_PLUG_PATH" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "[OK] vim-plug installed"
else
    echo "[SKIP] vim-plug already installed"
fi

# Install plugins
echo "[INFO] Installing Vim plugins (this may take a moment)..."
vim +PlugInstall +qall
echo "[OK] Vim plugins installed"
echo ""

# ============================================================
#                    SET ZSH AS DEFAULT SHELL
# ============================================================
echo "[OPTIONAL] Setting Zsh as default shell..."

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "[INFO] Current shell: $SHELL"
    echo "[INFO] Changing default shell to zsh..."

    # Add zsh to /etc/shells if not present
    if ! grep -q "$(which zsh)" /etc/shells; then
        echo "[SUDO] Adding zsh to /etc/shells..."
        echo "$(which zsh)" | sudo tee -a /etc/shells
    fi

    # Change shell
    chsh -s "$(which zsh)"
    echo "[OK] Default shell changed to zsh"
else
    echo "[SKIP] Zsh is already the default shell"
fi
echo ""

# ============================================================
#                    POST-INSTALL NOTES
# ============================================================
echo "=========================================="
echo "  Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Log out and log back in (or run: exec zsh)"
echo "  2. Open Vim and verify plugins loaded correctly"
echo "  3. Configure Vim LSP (CoC) if needed:"
echo "     :CocInstall coc-json coc-tsserver coc-python"
echo ""
echo "Optional:"
echo "  - Install Node.js for CoC LSP support"
echo "  - Configure fzf keybindings: \$(brew --prefix)/opt/fzf/install"
echo ""
echo "Installed:"
echo "  - Zsh with Oh My Zsh"
echo "  - Custom Sobole theme (dark mode)"
echo "  - Vim with plugins (NERDTree, fzf, CoC, etc.)"
echo "  - Vim color schemes (vs_dark, vs_light)"
echo "  - Syntax highlighting for Zsh"
echo ""
echo "Your original .zshrc and .vimrc have been backed up"
echo "to .zshrc.backup and .vimrc.backup if they existed."
echo ""
echo "Enjoy your new setup!"
echo "=========================================="