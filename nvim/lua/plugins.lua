-- ============================================================
--                       PLUGINS
-- ============================================================
-- Plugin specs for lazy.nvim. Each entry is the neovim-native
-- equivalent of a vim-plug plugin from the original vimrc.

return {
   -- Treesitter (parser installation + highlight)
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter").setup({
            ensure_installed = {
               "c", "cpp", "python", "rust", "go", "lua",
               "javascript", "typescript", "markdown", "json", "bash",
            },
         })
         -- vim.api.nvim_create_autocmd("FileType", {
         --    callback = function()
         --       pcall(vim.treesitter.start)
         --    end,
         -- })
      end,
   },

   -- Mason (LSP server installer)
   {
      "williamboman/mason.nvim",
      config = function()
         require("mason").setup()
      end,
   },

   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", "hrsh7th/cmp-nvim-lsp" },
      config = function()
         require("mason-lspconfig").setup({
            ensure_installed = {
               "clangd", "pyright", "rust_analyzer", "gopls", "ts_ls",
            },
         })

         -- Configure LSP servers using neovim 0.11+ native API
         local capabilities = require("cmp_nvim_lsp").default_capabilities()

         -- Apply capabilities to all servers
         vim.lsp.config("*", {
            capabilities = capabilities,
         })

         vim.lsp.config("clangd", {
            cmd = { "clangd", "--clang-tidy", "--header-filter=.*" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
         })

         vim.lsp.config("pyright", {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
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

         vim.lsp.config("rust_analyzer", {
            cmd = { "rust-analyzer" },
            filetypes = { "rust" },
            root_markers = { "Cargo.toml", "rust-project.json", ".git" },
            settings = {
               ["rust-analyzer"] = { check = { command = "clippy" } },
            },
         })

         vim.lsp.config("gopls", {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_markers = { "go.mod", "go.work", ".git" },
            settings = {
               gopls = { staticcheck = true },
            },
         })

         vim.lsp.config("ts_ls", {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
         })

         vim.lsp.enable({ "clangd", "pyright", "rust_analyzer", "gopls", "ts_ls" })

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
         telescope.setup({
            defaults = {
               vimgrep_arguments = {
                  "rg", "--color=never", "--no-heading", "--with-filename",
                  "--line-number", "--column", "--smart-case", "--hidden",
                  "--glob", "!.git/",
               },
            },
            pickers = {
               find_files = {
                  hidden = true,
                  file_ignore_patterns = { "^.git/" },
               },
            },
         })
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
               options = { number = true, numberwidth = 20 },
            },
            backdrop = 0,
         })
      end,
   },

   -- Rainbow delimiters (replaces luochen1990/rainbow)
   { "HiPhish/rainbow-delimiters.nvim" },

   -- Git: gutter signs, blame popup, hunk preview
   {
      "lewis6991/gitsigns.nvim",
      config = function()
         require("gitsigns").setup({
            current_line_blame = false,
         })
      end,
   },

   -- Git: full commit/diff browser
   {
      "sindrets/diffview.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
   },

   -- Git: unified diff & git commands (:Git diff, :Git blame, :Git log)
   { "tpope/vim-fugitive" },
}
