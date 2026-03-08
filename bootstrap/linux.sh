#!/usr/bin/env bash
#
# Bootstrap script for Linux systems
# Assembles modular components for dotfiles setup
#
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
export DOTFILES_DIR

echo "=========================================="
echo "  Dotfiles Bootstrap for Linux"
echo "=========================================="
echo ""

# Load components
source "$SCRIPT_DIR/components/packages_linux.sh"
source "$SCRIPT_DIR/components/ohmyzsh.sh"
source "$SCRIPT_DIR/components/zsh_syntax_linux.sh"
source "$SCRIPT_DIR/components/directories.sh"
source "$SCRIPT_DIR/components/dotfiles.sh"
source "$SCRIPT_DIR/components/vim.sh"
source "$SCRIPT_DIR/components/fzf.sh"
source "$SCRIPT_DIR/components/shell.sh"

# Run components
install_packages_linux
echo ""
install_ohmyzsh
echo ""
install_zsh_syntax_linux
echo ""
create_directories
echo ""
link_dotfiles
echo ""
install_vim_plugins
echo ""
install_fzf_linux
echo ""
set_default_shell_linux
echo ""

echo "=========================================="
echo "  Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Open Vim and verify plugins loaded correctly"
echo ""
