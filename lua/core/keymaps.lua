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

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

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
keymap("n", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')
keymap("v", "<leader>y", '"+y')
-- Delete to clipboard
keymap("n", "<leader>d", '"+d')
keymap("n", "<leader>D", '"+D')
keymap("v", "<leader>d", '"+d')
-- Paste from clipboard
keymap("n", "<leader>p", '"+p')
keymap("v", "<leader>p", '"+p')

-- Press jk fast to enter
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

-- use tab to go end of line & shift + tab to go to first character in line
keymap("n", "<tab>", "$", { desc = "go to end of line" })
keymap("n", "<S-Tab>", "^", { desc = "go to first character" })

-- oil.nvim
-- keymap("n", "-", require("oil").open, { desc = "Open parent directory" })

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
