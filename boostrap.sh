#!/bin/bash
set -e

echo "🚀 Starting dotfiles setup..."

# --- Install Homebrew packages ---
if [ -f Brewfile ]; then
  echo "📦 Installing Brewfile packages..."
  brew bundle --file=Brewfile
fi

# --- Vim setup ---
echo "📝 Setting up Vim..."
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Link vimrc
if [ -f vim/vimrc ]; then
  ln -sf $PWD/vim/vimrc ~/.vimrc
fi

# --- Hyper setup ---
if [ -f hyper/.hyper.js ]; then
  echo "⚡ Setting up Hyper..."
  ln -sf $PWD/hyper/.hyper.js ~/.hyper.js
fi

# --- Zsh + Oh My Zsh setup ---
echo "🐚 Installing Oh My Zsh (if missing)..."
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Link zshrc
if [ -f zsh/zshrc ]; then
  ln -sf $PWD/zsh/zshrc ~/.zshrc
fi

# Link theme
if [ -f zsh/sobole.zsh-theme ]; then
  ln -sf $PWD/zsh/sobole.zsh-theme ~/.oh-my-zsh/custom/themes/sobole.zsh-theme
fi

# --- VSCode setup ---
echo "🖥 Setting up VSCode..."
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_DIR/snippets"

if [ -f vscode/settings.json ]; then
  ln -sf "$PWD/vscode/settings.json" "$VSCODE_DIR/settings.json"
fi

if [ -f vscode/author.code-snippets ]; then
  ln -sf "$PWD/vscode/author.code-snippets" "$VSCODE_DIR/snippets/author.code-snippets"
fi

if [ -f vscode/python-author.code-snippets ]; then
  ln -sf "$PWD/vscode/python-author.code-snippets" "$VSCODE_DIR/snippets/python-author.code-snippets"
fi

# --- Fonts ---
echo "🔤 Installing fonts..."
mkdir -p ~/Library/Fonts
cp -n fonts/*.ttf ~/Library/Fonts/

echo "✅ Setup complete! Restart your terminal and run :PlugInstall inside Vim."

