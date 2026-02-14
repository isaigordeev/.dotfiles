-- ============================================================
--                   NEOVIM CONFIGURATION
-- ============================================================
-- Equivalent to vim/.vimrc — same features, keybindings, layout
--
-- Plugins (neovim-native equivalents):
--   CoC           → nvim-lspconfig + mason + nvim-cmp
--   NERDTree      → nvim-tree.lua
--   fzf.vim       → telescope.nvim
--   NERDCommenter → Comment.nvim
--   goyo.vim      → zen-mode.nvim
--   rainbow       → rainbow-delimiters.nvim
--   (new)         → nvim-treesitter

require("options")
require("russian")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git", "clone", "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins"))
require("keymaps")

vim.cmd("colorscheme vs_light")
