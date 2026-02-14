-- ============================================================
--                       KEYMAPS
-- ============================================================
-- All keybindings in one place, matching vim/.vimrc exactly.
-- Leader mappings are duplicated for Russian layout via lmap().

local map = vim.keymap.set

-- English → Russian mapping for leader key duplication
local eng_to_ru = {
   q="й", w="ц", e="у", r="к", t="е", y="н", u="г", i="ш", o="щ", p="з",
   a="ф", s="ы", d="в", f="а", g="п", h="р", j="о", k="л", l="д",
   z="я", x="ч", c="с", v="м", b="и", n="т", m="ь",
   Q="Й", W="Ц", E="У", R="К", T="Е", Y="Н", U="Г", I="Ш", O="Щ", P="З",
   A="Ф", S="Ы", D="В", F="А", G="П", H="Р", J="О", K="Л", L="Д",
   Z="Я", X="Ч", C="С", V="М", B="И", N="Т", M="Ь",
}

-- Map leader key for both English and Russian layouts
local function lmap(mode, key, action, opts)
   opts = opts or {}
   map(mode, "<leader>" .. key, action, opts)
   if eng_to_ru[key] then
      map(mode, "<leader>" .. eng_to_ru[key], action, opts)
   end
end


-- ─── File management ────────────────────────────────────────────
lmap("n", "s", "<cmd>w<CR>", { desc = "Save file" })
lmap("n", "w", "<cmd>q<CR>", { desc = "Quit file" })
lmap("n", "W", "<cmd>q!<CR>", { desc = "Quit without saving" })
lmap("n", "Q", "<cmd>qa<CR>", { desc = "Quit all" })


-- ─── Split management ───────────────────────────────────────────
lmap("n", "h", "<C-w>h", { desc = "Move to left split" })
lmap("n", "j", "<C-w>j", { desc = "Move to below split" })
lmap("n", "k", "<C-w>k", { desc = "Move to above split" })
lmap("n", "l", "<C-w>l", { desc = "Move to right split" })

map("n", "<leader>+", "<cmd>resize +5<CR>", { desc = "Increase height" })
map("n", "<leader>-", "<cmd>resize -5<CR>", { desc = "Decrease height" })
map("n", "<leader><", "<cmd>vertical resize -5<CR>", { desc = "Decrease width" })
map("n", "<leader>>", "<cmd>vertical resize +5<CR>", { desc = "Increase width" })
map("n", "<leader>=", "<C-w>=", { desc = "Equalize splits" })


-- ─── Fuzzy find (Telescope) ─────────────────────────────────────
lmap("n", "p", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
lmap("n", "b", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
lmap("n", "c", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in buffer" })
lmap("n", "a", "<cmd>Telescope live_grep<CR>", { desc = "Live ripgrep" })
lmap("n", "A", "<cmd>Telescope grep_string<CR>", { desc = "Grep word under cursor" })

-- Search across open buffers (equivalent to :Lines)
lmap("n", "e", function()
   require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "Search open buffers" })

map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })


-- ─── File tree (nvim-tree, replaces NERDTree) ───────────────────
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<C-f>", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in tree" })


-- ─── Commenting (Comment.nvim, replaces NERDCommenter) ──────────
map("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })


-- ─── History & clipboard ────────────────────────────────────────
lmap("n", ";", "q:", { desc = "Command history" })
lmap("n", "/", "q/", { desc = "Search history" })

-- Swap jump list navigation (Ctrl+I = back, Ctrl+O = forward)
map("n", "<C-i>", "<C-o>", { noremap = true, desc = "Jump back" })
map("n", "<C-o>", "<C-i>", { noremap = true, desc = "Jump forward" })

-- Yank to system clipboard (visual mode)
lmap("v", "y", '"+y', { desc = "Yank to clipboard" })

-- Reselect last visual selection
lmap("n", "v", "gv", { desc = "Reselect visual" })


-- ─── Sessions ───────────────────────────────────────────────────
local session_path = vim.fn.stdpath("data") .. "/session.vim"

lmap("n", "<Tab>", "<cmd>mksession! " .. session_path .. "<CR><cmd>echo 'Session saved!'<CR>",
   { desc = "Save session" })
lmap("n", "<S-Tab>", "<cmd>source " .. session_path .. "<CR><cmd>echo 'Session loaded!'<CR>",
   { desc = "Load session" })


-- ─── Zen mode (replaces Goyo) ───────────────────────────────────
lmap("n", "z", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })


-- ─── Timestamps ─────────────────────────────────────────────────
lmap("n", "t", function()
   vim.api.nvim_put({ os.date("%a %d %b %Y at %H:%M:%S") }, "c", true, true)
end, { desc = "Insert date" })

lmap("n", "T", function()
   vim.api.nvim_put({ os.date("%Y-%m-%d %H:%M") }, "c", true, true)
end, { desc = "Insert timestamp" })


-- ─── LSP keymaps (on attach) ───────────────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }
      map("n", "gd", vim.lsp.buf.definition, opts)
      map("n", "gy", vim.lsp.buf.type_definition, opts)
      map("n", "gi", vim.lsp.buf.implementation, opts)
      map("n", "gr", vim.lsp.buf.references, opts)
      map("n", "K", vim.lsp.buf.hover, opts)
   end,
})
