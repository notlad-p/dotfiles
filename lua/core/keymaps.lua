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
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- better up & down, goes through visual lines not file lines
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- write files
keymap("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })

-- safe quit with native confirm (enhanced with noice.nvim)
keymap("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit" })

-- safe close buffer
keymap("n", "<leader>c", "<cmd>confirm bd<CR>", { desc = "Close buffer" })

-- remove search highlight
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Remove search highlight" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move Buffers
keymap("n", "<S-Right>", ":BufferLineMoveNext<CR>")
keymap("n", "<S-Left>", ":BufferLineMovePrev<CR>")

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Toggle nvim-tree
keymap("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>")

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

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("v", "p", '"_dP')

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Useful insert mode motions
keymap("i", "<C-,>", "<C-o>^", { desc = "Beginning of line" })
keymap("i", "<C-.>", "<C-o>$", { desc = "End of line" })

-- windows
keymap("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
keymap("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last" })
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First" })
keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next" })
keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close" })
keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous" })

-- open Location / Quickfix list
keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- open lazygit in a floating term
keymap("n", "<leader>gl", function()
  require("lazy.util").float_term { "lazygit" }
end, { desc = "Lazygit" })
