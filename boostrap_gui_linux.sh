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
echo "[STEP 1/7] Installing required packages..."

install_packages() {
    case "$PKG_MANAGER" in
        apt)
            sudo apt-get update
            sudo apt-get install -y zsh git curl vim fzf ripgrep nodejs npm
            ;;
        dnf)
            sudo dnf install -y zsh git curl vim fzf ripgrep nodejs npm
            ;;
        yum)
            sudo yum install -y zsh git curl vim fzf nodejs npm
            # ripgrep might need EPEL
            ;;
        pacman)
            sudo pacman -Sy --noconfirm zsh git curl vim fzf ripgrep nodejs npm
            ;;
        zypper)
            sudo zypper install -y zsh git curl vim fzf ripgrep nodejs npm
            ;;
        *)
            echo "[ERROR] Unknown package manager. Please install manually:"
            echo "  - zsh"
            echo "  - git"
            echo "  - curl"
            echo "  - vim"
            echo "  - fzf"
            echo "  - ripgrep (optional)"
            echo "  - nodejs and npm (for CoC LSP)"
            exit 1
            ;;
    esac
}

install_packages
echo "[OK] Packages installed"

# Verify Node.js installation
if command -v node > /dev/null 2>&1; then
    echo "[INFO] Node.js version: $(node --version)"
    echo "[INFO] npm version: $(npm --version)"
else
    echo "[WARN] Node.js not found in PATH. CoC may not work."
fi
echo ""

# ============================================================
#                    INSTALL OH MY ZSH
# ============================================================
echo "[STEP 2/7] Installing Oh My Zsh..."

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
echo "[STEP 3/7] Installing zsh-syntax-highlighting..."

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
echo "[STEP 4/7] Creating required directories..."

mkdir -p "$HOME/.vim/colors"
mkdir -p "$HOME/.oh-my-zsh/custom/themes"
echo "[OK] Directories created"
echo ""

# ============================================================
#                    LINK DOTFILES
# ============================================================
echo "[STEP 5/7] Linking dotfiles..."

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
echo "[STEP 6/7] Installing Vim plugins..."

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
#                    SETUP FZF KEYBINDINGS
# ============================================================
echo "[STEP 7/7] Setting up fzf keybindings..."

# Always install fzf from source for consistent experience and latest features
# Package manager versions are often outdated and missing --zsh support
if [ ! -d "$HOME/.fzf" ]; then
    echo "[INFO] Installing fzf from source for full features..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    echo "[OK] fzf installed from source with keybindings"
else
    echo "[SKIP] fzf already installed from source"
fi

# Always ensure fzf is sourced at the END of .zshrc (after oh-my-zsh)
# Remove any existing fzf lines first to avoid duplicates
if [ -f "$HOME/.zshrc" ]; then
    # Create a temporary file without fzf lines
    grep -v "fzf" "$HOME/.zshrc" > "$HOME/.zshrc.tmp" || true
    mv "$HOME/.zshrc.tmp" "$HOME/.zshrc"

    # Add fzf at the end
    echo "" >> "$HOME/.zshrc"
    echo "# fzf keybindings and completion (must be at end)" >> "$HOME/.zshrc"
    echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> "$HOME/.zshrc"
    echo "[OK] Added fzf keybindings to end of .zshrc"
fi
echo ""

# ============================================================
#                    SET ZSH AS DEFAULT SHELL
# ============================================================
echo "[OPTIONAL] Setting Zsh as default shell..."

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "[INFO] Current shell: $SHELL"
    echo "[INFO] Attempting to change default shell to zsh..."

    # Add zsh to /etc/shells if not present
    if ! grep -q "$(which zsh)" /etc/shells 2>/dev/null; then
        echo "[SUDO] Adding zsh to /etc/shells..."
        echo "$(which zsh)" | sudo tee -a /etc/shells > /dev/null
    fi

    # Try to change shell
    if chsh -s "$(which zsh)" 2>/dev/null; then
        echo "[OK] Default shell changed to zsh"
    else
        echo "[WARN] Could not change default shell automatically (PAM authentication failed)"
        echo "[INFO] You can change it manually with one of these methods:"
        echo ""
        echo "  Method 1: Run this command and enter your password:"
        echo "    sudo chsh -s \$(which zsh) \$USER"
        echo ""
        echo "  Method 2: For now, just start zsh manually:"
        echo "    exec zsh"
        echo ""
        echo "  Method 3: Add to your ~/.bashrc or ~/.bash_profile:"
        echo "    if [ -t 1 ]; then"
        echo "      exec zsh"
        echo "    fi"
    fi
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
echo "Installed:"
echo "  - Zsh with Oh My Zsh"
echo "  - Custom Sobole theme (dark mode)"
echo "  - Vim with plugins (NERDTree, fzf, CoC, etc.)"
echo "  - Vim color schemes (vs_dark, vs_light)"
echo "  - Syntax highlighting for Zsh"
echo "  - fzf fuzzy finder with keybindings"
echo "  - ripgrep for fast searching"
echo "  - Node.js and npm for CoC LSP support"
echo ""
echo "Your original .zshrc and .vimrc have been backed up"
echo "to .zshrc.backup and .vimrc.backup if they existed."
echo ""
echo "Enjoy your new setup!"
echo "=========================================="