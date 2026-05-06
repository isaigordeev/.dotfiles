#!/usr/bin/env bash
#
# Bootstrap script for Darwin (macOS) systems
# Assembles modular components for dotfiles setup
#
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
export DOTFILES_DIR

echo "=========================================="
echo "  Dotfiles Bootstrap for Darwin"
echo "=========================================="
echo ""

# Load components
source "$SCRIPT_DIR/components/homebrew.sh"
source "$SCRIPT_DIR/components/packages_darwin.sh"
source "$SCRIPT_DIR/components/gui_apps_darwin.sh"
source "$SCRIPT_DIR/components/ohmyzsh.sh"
source "$SCRIPT_DIR/components/directories.sh"
source "$SCRIPT_DIR/components/dotfiles.sh"
source "$SCRIPT_DIR/components/vscode.sh"
source "$SCRIPT_DIR/components/hyper.sh"
source "$SCRIPT_DIR/components/fonts.sh"
source "$SCRIPT_DIR/components/tig.sh"
source "$SCRIPT_DIR/components/vim.sh"
source "$SCRIPT_DIR/components/fzf.sh"
source "$SCRIPT_DIR/components/shell.sh"
source "$SCRIPT_DIR/components/keyremap.sh"

# Run components
install_homebrew
echo ""
install_packages_darwin
echo ""
install_gui_apps_darwin
echo ""
install_ohmyzsh
echo ""
create_directories
echo ""
link_dotfiles
echo ""
link_vscode_darwin
echo ""
link_hyper
echo ""
install_fonts_darwin
echo ""
link_tig
echo ""
install_vim_plugins
echo ""
install_fzf_darwin
echo ""
set_default_shell_darwin
echo ""
install_keyremap_darwin
echo ""

echo "=========================================="
echo "  Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Open Vim and verify plugins loaded correctly"
echo ""
