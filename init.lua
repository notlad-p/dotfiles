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

-- setup keymaps & leader key
-- must be before lazy.nvim
require "user.keymaps"
require "user.options"

-- any plugins in the lua/user/plugins/ directory
-- will be merged in the main plugin spec
require("lazy").setup "plugins"

require("user.autocmds").setup()

-- treat mdx files as markdown files
vim.filetype.add {
  extension = {
    mdx = "markdown",
  },
}
