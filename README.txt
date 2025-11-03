
MINIMAL VIM & VSCODE & ZSH SETUP
================================

for MacOS 

A lightweight, keyboard-friendly setup for Vim and Zsh.
Perfect for old Linux/macOS systems or large codebases (~1M lines)
without relying on heavy IDEs like CLion.

-------------------------------------------------------------------------------
0. Set .zshrc
-------------------------------------------------------------------------------

    > ln -fs "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"

-------------------------------------------------------------------------------
1. Install Zsh
-------------------------------------------------------------------------------

Download and install Zsh via curl (if not already installed):

    > curl -L https://example.com/install-zsh.sh | sh

-------------------------------------------------------------------------------
2. Vim Setup
-------------------------------------------------------------------------------

Install vim-plug (plugin manager):

    > curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Install Plugins:
1. Open Vim:
    
    > vim

2. Inside Vim, run:

    :PlugInstall

Reload Vim and enjoy a minimal, fast setup.

-------------------------------------------------------------------------------
3. Install Oh My Zsh
-------------------------------------------------------------------------------

    > sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

-------------------------------------------------------------------------------
4. Syntax Highlighting
-------------------------------------------------------------------------------

Add Zsh syntax highlighting to your .zshrc:

    > echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

Reload Zsh:

    > source ~/.zshrc

-------------------------------------------------------------------------------
5. Load a Custom Theme
-------------------------------------------------------------------------------

Link a theme file:

    > ln -fs "$HOME/.dotfiles/zsh/sobole.zsh-theme" "$HOME/.oh-my-zsh/custom/
    themes/sobole.zsh-theme"

Set it in .zshrc:

    ZSH_THEME="sobole"

Reload Zsh:

    > source ~/.zshrc

-------------------------------------------------------------------------------
DONE!
-------------------------------------------------------------------------------

You now have a minimal, fast, keyboard-friendly environment:
- Vim with plugins via vim-plug
- Oh My Zsh with syntax highlighting and a custom theme
- Lightweight setup ideal for big codebases or older systems
