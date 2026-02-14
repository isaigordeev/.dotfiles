-- ============================================================
--                       PLUGINS
-- ============================================================
-- Plugin specs for lazy.nvim. Each entry is the neovim-native
-- equivalent of a vim-plug plugin from the original vimrc.

return {
   -- Treesitter (syntax highlighting, indent, required for rainbow)
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter.configs").setup({
            ensure_installed = {
               "c", "cpp", "python", "rust", "go", "lua",
               "javascript", "typescript", "markdown", "json", "bash",
            },
            highlight = { enable = true },
            indent = { enable = true },
         })
      end,
   },

   -- LSP (replaces CoC)
   {
      "neovim/nvim-lspconfig",
      dependencies = {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
      },
      config = function()
         require("mason").setup()
         require("mason-lspconfig").setup({
            ensure_installed = {
               "clangd", "pyright", "rust_analyzer", "gopls", "ts_ls",
            },
         })

         local lspconfig = require("lspconfig")
         local capabilities = require("cmp_nvim_lsp").default_capabilities()

         lspconfig.clangd.setup({
            capabilities = capabilities,
            cmd = { "clangd", "--clang-tidy", "--header-filter=.*" },
         })

         lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
               python = {
                  analysis = {
                     typeCheckingMode = "strict",
                     autoImportCompletions = true,
                     diagnosticMode = "workspace",
                  },
               },
            },
         })

         lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            settings = {
               ["rust-analyzer"] = { check = { command = "clippy" } },
            },
         })

         lspconfig.gopls.setup({
            capabilities = capabilities,
            settings = {
               gopls = { staticcheck = true },
            },
         })

         lspconfig.ts_ls.setup({ capabilities = capabilities })

         -- Disable diagnostic signs (matches coc-settings.json)
         vim.diagnostic.config({ signs = false })

         -- Format on save for specific filetypes
         vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.md", "*.json", "*.rs", "*.go" },
            callback = function()
               vim.lsp.buf.format({ async = false })
            end,
         })
      end,
   },

   -- Completion (replaces CoC completion)
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "L3MON4D3/LuaSnip",
         "saadparwaiz1/cmp_luasnip",
      },
      config = function()
         local cmp = require("cmp")
         cmp.setup({
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },
            mapping = cmp.mapping.preset.insert({
               ["<CR>"] = cmp.mapping.confirm({ select = true }),
               ["<C-j>"] = cmp.mapping.select_next_item(),
               ["<C-k>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
               { name = "nvim_lsp" },
               { name = "luasnip" },
            }, {
               { name = "buffer" },
               { name = "path" },
            }),
         })
      end,
   },

   -- File tree (replaces NERDTree)
   {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
         require("nvim-tree").setup({
            view = { width = 40, number = true },
            filters = { dotfiles = false },
         })
      end,
   },

   -- Fuzzy finder (replaces fzf.vim)
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      config = function()
         local telescope = require("telescope")
         telescope.setup({})
         telescope.load_extension("fzf")
      end,
   },

   -- Commenting (replaces NERDCommenter)
   {
      "numToStr/Comment.nvim",
      config = function()
         require("Comment").setup()
      end,
   },

   -- Zen mode (replaces goyo.vim)
   {
      "folke/zen-mode.nvim",
      config = function()
         require("zen-mode").setup({
            window = {
               width = 0.85,
               options = { number = true },
            },
         })
      end,
   },

   -- Rainbow delimiters (replaces luochen1990/rainbow)
   { "HiPhish/rainbow-delimiters.nvim" },
}
