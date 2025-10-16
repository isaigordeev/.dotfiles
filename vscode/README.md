## install exts

xargs -n 1 code --install-extension < vscode_extensions.txt

## link dir from the repo root
ln -s "$(pwd)/vscode" /Users/you/linked-folder/.vscode


## to test this repo
ln -s "$(pwd)/vscode" "$(pwd)/.vscode"

## to bind keybinds of vscode on MacOS
ln -s "$(pwd)/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

## to bind general appearance settings of vscode on MacOS
ln -s "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
