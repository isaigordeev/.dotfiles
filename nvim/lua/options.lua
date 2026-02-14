-- ============================================================
--                    BASIC SETTINGS
-- ============================================================

-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw (using nvim-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Colors
vim.opt.termguicolors = true
vim.opt.background = "light"

-- Wrap
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↳ "
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2,min:20"

-- Tabs & indents
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true

-- Navigation & search
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.incsearch = true
vim.opt.scrolloff = 4

-- Auto-indent
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.copyindent = true

-- Update & timing
vim.opt.showtabline = 0
vim.opt.updatetime = 300
vim.opt.redrawtime = 10000
