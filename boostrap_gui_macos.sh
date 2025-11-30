#!/usr/bin/env bash
#
# Bootstrap script for macOS systems
# Sets up dotfiles: zsh, vim, and related configurations
#
set -e

DOTFILES_DIR="$HOME/.dotfiles"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================="
echo "  Dotfiles Bootstrap for macOS"
echo "=========================================="
echo ""

# ============================================================
#                    INSTALL HOMEBREW
# ============================================================
echo "[STEP 1/6] Checking Homebrew..."

if ! command -v brew > /dev/null 2>&1; then
    echo "[INFO] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo "[INFO] Configuring Homebrew for Apple Silicon..."
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "[OK] Homebrew installed"
else
    echo "[SKIP] Homebrew already installed"
fi
echo ""

# ============================================================
#                    INSTALL PACKAGES
# ============================================================
echo "[STEP 2/6] Installing required packages..."

# Update Homebrew
brew update

# Install packages
brew install zsh git curl vim fzf ripgrep

# Install zsh-syntax-highlighting
brew install zsh-syntax-highlighting

echo "[OK] Packages installed"
echo ""
# ============================================================
#                    INSTALL OH MY ZSH
# ============================================================
echo "[STEP 3/6] Installing Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "[OK] Oh My Zsh installed"
else
    echo "[SKIP] Oh My Zsh already installed"
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

# Add syntax highlighting to .zshrc if not already there
if ! grep -q "zsh-syntax-highlighting.zsh" "$HOME/.zshrc" 2>/dev/null; then
    echo "" >> "$HOME/.zshrc"
    echo "# Syntax highlighting (Homebrew)" >> "$HOME/.zshrc"
    echo "source \$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
    echo "[OK] Added syntax highlighting to .zshrc"
fi

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
#                    INSTALL FZF KEYBINDINGS
# ============================================================
echo "[OPTIONAL] Installing fzf keybindings..."

if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    echo "[OK] fzf keybindings installed"
else
    echo "[SKIP] fzf install script not found"
fi
echo ""

# ============================================================
#                    SET ZSH AS DEFAULT SHELL
# ============================================================
echo "[OPTIONAL] Setting Zsh as default shell..."

BREW_ZSH=$(brew --prefix)/bin/zsh

if [ "$SHELL" != "$BREW_ZSH" ]; then
    echo "[INFO] Current shell: $SHELL"
    echo "[INFO] Attempting to change default shell to Homebrew zsh..."

    # Add Homebrew zsh to /etc/shells if not present
    if ! grep -q "$BREW_ZSH" /etc/shells 2>/dev/null; then
        echo "[SUDO] Adding Homebrew zsh to /etc/shells..."
        echo "$BREW_ZSH" | sudo tee -a /etc/shells > /dev/null
    fi

    # Try to change shell
    if chsh -s "$BREW_ZSH" 2>/dev/null; then
        echo "[OK] Default shell changed to Homebrew zsh"
    else
        echo "[WARN] Could not change default shell automatically"
        echo "[INFO] You can change it manually with:"
        echo "    sudo chsh -s $BREW_ZSH $USER"
    fi
else
    echo "[SKIP] Homebrew zsh is already the default shell"
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
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Open Vim and verify plugins loaded correctly"
echo "  3. Configure Vim LSP (CoC) if needed:"
echo "     :CocInstall coc-json coc-tsserver coc-python"
echo ""
echo "Optional:"
echo "  - Install Node.js for CoC LSP support:"
echo "    brew install node"
echo "  - Install additional fonts from ./fonts/"
echo "  - Set up VSCode/Hyper configs if needed"
echo ""
echo "Installed:"
echo "  - Homebrew package manager"
echo "  - Zsh with Oh My Zsh"
echo "  - Custom Sobole theme (dark mode)"
echo "  - Vim with plugins (NERDTree, fzf, CoC, etc.)"
echo "  - Vim color schemes (vs_dark, vs_light)"
echo "  - Syntax highlighting for Zsh"
echo "  - fzf fuzzy finder with keybindings"
echo "  - ripgrep for fast searching"
echo ""
echo "Your original .zshrc and .vimrc have been backed up"
echo "to .zshrc.backup and .vimrc.backup if they existed."
echo ""
echo "Enjoy your new setup!"
echo "=========================================="