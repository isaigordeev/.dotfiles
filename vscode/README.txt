
VSCODE GLOBAL SETUP
===================

1. Install extensions from a list
---------------------------------

Use a text file containing extension IDs (one per line) to install:

    > xargs -n 1 code --install-extension < vscode_extensions.txt

-------------------------------------------------------------------------------
2. Link VSCode folder from repo root
-------------------------------------

Create a symlink to your VSCode configuration folder:

    > ln -s "./vscode" "path-to-linked-folder/.vscode"

-------------------------------------------------------------------------------
3. Test this repo locally
-------------------------

Link the vscode folder in the local repository:

    > ln -s "./vscode" "$./.vscode"

-------------------------------------------------------------------------------
4. Bind keybindings on MacOS
----------------------------

Link keybindings.json to the VSCode user folder:

    > ln -s "$./vscode/keybindings.json" \
          "$HOME/Library/Application Support/Code/User/keybindings.json"

-------------------------------------------------------------------------------
5. Bind general appearance settings on MacOS
--------------------------------------------

Link settings.json to the VSCode user folder:

    > ln -s "./vscode/settings.json" \
          "$HOME/Library/Application Support/Code/User/settings.json"

-------------------------------------------------------------------------------
6. Update/check all VSCode extensions
--------------------------------------

Export currently installed extensions to a text file:

    > code --list-extensions > vscode-extensions.txt
