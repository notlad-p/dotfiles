-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function del(mode, key)
  vim.keymap.del(mode, key)
end

-- Shorten function name
local function keymap(mode, key, map, options)
  local opts = { noremap = true, silent = true }

  if options then
    opts = vim.tbl_extend("force", opts, options)
  end

  vim.keymap.set(mode, key, map, opts)
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

----------------------------
-- Move default LazyVim maps
----------------------------

-- w to W
del("n", "<leader>wd")
del("n", "<leader>wm")
keymap("n", "<leader>Wd", "<C-W>c", { desc = "Delete Window", remap = true })
Snacks.toggle.zoom():map("<leader>Wm"):map("<leader>uZ")

-- LSP (code)
del("n", "<leader>cf")
del("n", "<leader>cd")

keymap("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- write files (first replace top level `w` maps)

keymap("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })

-- safe quit with native confirm (enhanced with noice.nvim)
del("n", "<leader>qq")
keymap("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit" })

-- safe close buffer
-- keymap("n", "<leader>c", "<cmd>confirm Bdelete<CR>", { desc = "Close buffer" })
keymap("n", "<leader>c", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- comment with lines quickly
del("n", "<leader>/")
keymap("n", "<leader>/", "<cmd>normal gcc<cr>", { desc = "Comment" })
keymap("v", "<leader>/", "<cmd>normal gcc<cr>", { desc = "Comment" })

-- search word
keymap("n", "<leader>t", function()
  Snacks.dashboard.pick("live_grep")
end, { desc = "Find Text (grep)" })

-- search files
-- del("n", "<leader> ")
keymap("n", "<leader><CR>", function()
  Snacks.dashboard.pick("files")
end, { desc = "Find files" })

-- Clipboard --
-- yank to clipboard
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })
-- Delete to clipboard
keymap({ "n", "v" }, "<leader>d", [["+d]], { desc = "Delete to clipboard" })
keymap("n", "<leader>D", [["+D]], { desc = "Delete line to clipboard" })
-- Paste from clipboard
keymap({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from clipboard" })

-- jk to enter normal mode
keymap("i", "jk", "<ESC>")

-- Don't replace clipboard text when pasting in visual mode
keymap("v", "p", '"_dP')

-- Useful insert mode motions
keymap("i", "<C-,>", "<C-o>^", { desc = "Beginning of line" })
keymap("i", "<C-.>", "<C-o>$", { desc = "End of line" })

-- format
--del("n", "l")
keymap({ "n" }, "<leader>lf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })
keymap({ "v" }, "<leader>f", function()
  vim.lsp.buf.format()
end, { desc = "Format" })

-- NOTE: removed because of yazi.nvim plugin, it was causing delays when pressing `j`
-- terminal escape
-- keymap("t", "jk", [[<C-\><C-n>]])
-- del("t", "jk")

-- keymap("n", "<leader>gy", "<cmd>set signcolumn=yes<CR>", { desc = "Show sign column" })
-- keymap("n", "<leader>W", "<cmd> set linebreak wrap<CR>", { desc = "Wrap and break lines" })

-- LazyVim & lazy.nvim
-- lazy
del("n", "<leader>l")
keymap("n", "<leader>Ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- LazyVim Changelog
del("n", "<leader>L")
keymap("n", "<leader>LL", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })

-- toggle enable/disable ai completion

keymap("n", "<leader>ac", "<cmd>Copilot toggle<cr>", { desc = "Toggle Copilot" })

-- keymap("n", "<leader>ac", function()
--   if not vim.g.copilot_enabled then
--     vim.g.copilot_enabled = true
--     return
--   end
--
--   require("copilot.command").toggle()
-- end, { desc = "Toggle Copilot" })
