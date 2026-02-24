
TIG SETUP
=========

1. Link tig configuration
--------------------------

Create a symlink from the repo tig configuration to your home directory:

    > ln -sf "$HOME/.dotfiles/tig/.tigrc" \
          "$HOME/.tigrc"

-------------------------------------------------------------------------------
2. Key bindings
---------------

main view:

    O   — checkout the selected commit
              git checkout %(commit)

