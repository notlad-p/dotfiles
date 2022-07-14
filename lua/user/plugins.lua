local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- File tree with icons
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("nvim-tree").setup()
		end,
	})

	-- onedark theme
	use({
		"navarasu/onedark.nvim",
		as = "onedark",
		config = function()
			local onedark = require("onedark")

			onedark.setup({
				style = "deep",
			})

			onedark.load()
		end,
	})

	-- treesitter styntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("user.treesitter").config()
		end,
	})

	-- bufferline
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("user.bufferline").config()
		end,
	})

	-- lualine status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("user.lualine").config()
		end,
	})

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
		event = "BufRead",
	})

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim")
	use("nvim-lua/plenary.nvim")

	-- completions
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("user.cmp").setup()
		end,
		requires = {
			"L3MON4D3/LuaSnip",
		},
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("saadparwaiz1/cmp_luasnip")

	-- snippets
	use("rafamadriz/friendly-snippets")
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = {
					"~/.config/nvim/snippets",
					"~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
				},
			})
		end,
	})

	-- autopairs / tags
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("user.autopairs").setup()
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
