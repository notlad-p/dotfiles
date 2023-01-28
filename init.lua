-- install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup core neovim features: keymaps, options, & autocmds
-- NOTE: leader key must be before lazy.nvim
require('core').setup()

-- any plugins in the lua/user/plugins/ directory
-- will be merged in the main plugin spec
require("lazy").setup "plugins"

-- treat mdx files as markdown files
vim.filetype.add {
  extension = {
    mdx = "markdown",
  },
}
