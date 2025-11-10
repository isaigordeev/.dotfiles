#!/usr/bin/env bash
set -e

# Install Zsh and syntax highlighting
brew install zsh zsh-syntax-highlighting

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create needed directories
mkdir -p "$HOME/.vim/colors"
mkdir -p "$HOME/.oh-my-zsh/custom/themes"

# Link Zsh config and theme
ln -fs "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -fs "$HOME/.dotfiles/zsh/sobole.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/sobole.zsh-theme"

# Add syntax highlighting plugin
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "${ZDOTDIR:-$HOME}/.zshrc"

# Link Vim config and color schemes
ln -fs "$HOME/.dotfiles/vim/.vimrc" "$HOME/.vimrc"
ln -fs "$HOME/.dotfiles/vim/.vim/colors/vs_dark.vim" "$HOME/.vim/colors/vs_dark.vim"
ln -fs "$HOME/.dotfiles/vim/.vim/colors/vs_light.vim" "$HOME/.vim/colors/vs_light.vim"

# Optional: make zsh the default shell
if [[ $SHELL != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
fi

echo "[INFO] Dotfiles setup complete. Open a new terminal to start using Zsh!"
