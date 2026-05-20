-- ============================================================
--                  GIT RANGE PICKER (DiffviewOpen)
-- ============================================================
-- Two-tier picker: vim.ui.select for common cases, Telescope
-- git pickers for the "pick a ref/commit" cases.

local M = {}

local function diffview(range)
   if range and range ~= "" then
      vim.cmd("DiffviewOpen " .. range)
   else
      vim.cmd("DiffviewOpen")
   end
end

local function pick_with_telescope(builtin_name, on_pick)
   local builtin = require("telescope.builtin")
   local actions = require("telescope.actions")
   local state = require("telescope.actions.state")
   builtin[builtin_name]({
      attach_mappings = function(_, map)
         local confirm = function(bufnr)
            local entry = state.get_selected_entry()
            actions.close(bufnr)
            if entry then on_pick(entry.value) end
         end
         map("i", "<CR>", confirm)
         map("n", "<CR>", confirm)
         return true
      end,
   })
end

function M.pick()
   local choices = {
      "vs HEAD (working tree)",
      "vs origin/main (PR diff)",
      "Last N commits...",
      "Pick base branch/tag (...HEAD)",
      "Pick base commit (..HEAD)",
      "Pick commit (show its diff)",
      "Custom range...",
   }
   vim.ui.select(choices, { prompt = "Diffview range:" }, function(choice)
      if not choice then return end
      if choice == choices[1] then
         diffview(nil)
      elseif choice == choices[2] then
         diffview("origin/main...HEAD")
      elseif choice == choices[3] then
         vim.ui.input({ prompt = "N = " }, function(n)
            if n and n:match("^%d+$") then
               diffview("HEAD~" .. n .. "..HEAD")
            end
         end)
      elseif choice == choices[4] then
         pick_with_telescope("git_branches", function(ref)
            diffview(ref .. "...HEAD")
         end)
      elseif choice == choices[5] then
         pick_with_telescope("git_commits", function(sha)
            diffview(sha .. "..HEAD")
         end)
      elseif choice == choices[6] then
         pick_with_telescope("git_commits", function(sha)
            diffview(sha .. "~.." .. sha)
         end)
      elseif choice == choices[7] then
         vim.ui.input({ prompt = "Range: " }, function(range)
            if range and range ~= "" then diffview(range) end
         end)
      end
   end)
end

return M
