
VIM SETUP
=========

1. Link Vim configuration
-------------------------

Create a symlink from the repo Vim configuration to your home directory:

    > ln -s "$(pwd)/vim/.vimrc" \
          "$HOME/.vimrc"

-------------------------------------------------------------------------------
2. Check LSP/Treesitter config inside Vim
-----------------------------------------

Open Vim and run:

    :CocConfig

-------------------------------------------------------------------------------
3. Install Python LSP (pylance) inside Vim
-------------------------------------------

Open Vim and run:

    :CocInstall coc-pyright

-------------------------------------------------------------------------------
4. Install C/C++ clang LSP inside Vim
--------------------------------------

Open Vim and run:

    :CocInstall coc-clangd
