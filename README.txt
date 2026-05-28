
DOTFILES
========

A minimal, keyboard-driven dev environment for macOS and Linux.
Built for older hardware and large codebases (~1M lines) where heavy
IDEs feel sluggish.

Includes configs for:
  - Zsh (Oh My Zsh + isg theme (forked from sobole) + fzf)
  - Vim and Neovim
  - Tmux (with TPM + tmux-resurrect)
  - Ghostty, Hyper, VSCode, Zed
  - Tig, JetBrains Mono + Computer Modern fonts
  - macOS defaults & key remapping

-------------------------------------------------------------------------------
QUICK START
-------------------------------------------------------------------------------

Clone into ~/.dotfiles:

    > git clone <repo-url> "$HOME/.dotfiles"
    > cd "$HOME/.dotfiles"

Run the bootstrap for your OS:

    > ./bootstrap/darwin.sh        # macOS
    > ./bootstrap/linux.sh         # Linux

The bootstrap is modular (see bootstrap/components/) and handles:
Homebrew, packages, Oh My Zsh, dotfile symlinks, vim-plug + plugins,
fzf, fonts, tig, vscode, hyper, key remapping, and macOS defaults.

Restart your terminal (or `exec zsh`) when it finishes.

-------------------------------------------------------------------------------
LAYOUT
-------------------------------------------------------------------------------

    bootstrap/      install scripts (darwin.sh, linux.sh + components/)
    zsh/            .zshrc, aliases, fzf integration, isg theme
    vim/            .vimrc, plugins, color schemes, coc extensions
    nvim/           init.lua + lazy.nvim setup
    tmux/           .tmux.conf
    ghostty/        terminal config
    hyper/          terminal config
    vscode/         settings + keybindings
    zed/            settings
    tig/            git TUI config
    fonts/          JetBrains Mono + Computer Modern
    darwin/         macOS system defaults + Brewfile
    prompt/         shell prompt definitions

-------------------------------------------------------------------------------
MANUAL SETUP (if you'd rather not run bootstrap)
-------------------------------------------------------------------------------

1. Link the core dotfiles:

    > ln -fs "$HOME/.dotfiles/zsh/.zshrc"      "$HOME/.zshrc"
    > ln -fs "$HOME/.dotfiles/vim/.vimrc"      "$HOME/.vimrc"
    > ln -fs "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
    > ln -fs "$HOME/.dotfiles/nvim"            "$HOME/.config/nvim"

2. Install Oh My Zsh:

    > sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

3. Link the theme:

    > ln -fs "$HOME/.dotfiles/zsh/isg.zsh-theme" \
             "$HOME/.oh-my-zsh/custom/themes/isg.zsh-theme"

   Then set ZSH_THEME="isg" in .zshrc.

4. Install vim-plug and plugins:

    > curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    > vim +PlugInstall +qall

5. Install TPM and tmux plugins:

    > git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

   Then inside tmux: prefix + I

6. Reload:

    > source ~/.zshrc

-------------------------------------------------------------------------------
NOTES
-------------------------------------------------------------------------------

  - tmux prefix bindings: see tmux/.tmux.conf (new windows open to the
    right of current; & kills window and moves focus left).
  - toggle_theme.sh switches macOS light/dark mode and adjacent terminal
    themes in one shot.
  - MANIFEST.txt lists the git worktrees used alongside main.
