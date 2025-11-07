brew install zsh
ln -fs "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

ln -fs "$HOME/.dotfiles/zsh/sobole.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/sobole.zsh-theme"


ln -fs "$HOME/.dotfiles/vim/.vimrc" "$HOME/.vimrc"

ln -fs "$HOME/.dotfiles/vim/.vim/colors/vs_dark.vim" "$HOME/.vim/vim/colors/vs_dark.vim"
 
ln -fs "$HOME/.dotfiles/vim/.vim/colors/vs_light.vim" "$HOME/.vim/vim/colors/vs_light.vim"