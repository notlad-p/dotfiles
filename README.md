# Neovim Config

### Installed Plugins

- [packer](https://github.com/wbthomason/packer.nvim) - plugin manager
- onedark - color scheme
- treesitter - syntax highlighting (note: Specific language parsers must be installed with `:TSInstall <language_to_install>`. Here's the [official documentation](https://github.com/nvim-treesitter/nvim-treesitter#language-parsers).)
- nvim-tree - file tree
- lualine - status line
- gitsigns - git integration
- nvim-lspconfig - LSP
- nvim-lsp-installer - easy to use LSP installer
- null-ls - for formatters and linter's (requires plenary.nvim)
  - You will need to install linters and formatters separately on your machine
    - For example [luacheck](https://github.com/mpeterv/luacheck#installation) and [stylua](https://github.com/JohnnyMorganz/StyLua#installation)
- nvim-cmp - completion engine
- cmp-nvim-lsp - completion plugin for LSP
- cmp-path - completion plugin for path
- cmp-buffer - completion plugin for current buffer
- cmp_luasnip - completion plugin for luasnip code snippets
- LuaSnip - snippet engine
- friendly-snippets - set of preconfigured snippets
- nvim-autopairs
- nvim-ts-autotag
- telescope.nvim - requires plenary.nvim
- telescope-fzf-native.nvim
- which-key.nvim
- alpha-nvim - start up dashboard
- toggleterm.nvim - floating terminal window
- bufdelete.nvim - delete buffers and keep window orientation
- vim-indent-object - adds indent text object
- vim-surround - adds surroundings text object
- indent-blankline.nvim - shows indent lines & current indent
- nvim-colorizer.lua - highlights color codes in editor
- lightspeed.nvim - better find motion
- neoscroll.nvim - smooth scrolling motions
- todo-comments.nvim - highlight, list, and search todo comments
- markdown-preview.nvim - preview markdown files

### Useful links

- Using system clipboard in [WSL](https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl)
