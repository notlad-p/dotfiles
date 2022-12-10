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
			require("user.nvimtree").setup()
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
				-- transparent = true,
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
	use("hrsh7th/cmp-nvim-lua")

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

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("user.telescope").setup()
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		run = "make",
	})

	-- project
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
		end,
	})

	-- comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("user.comment").config()
		end,
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufReadPost",
	})

	-- whichkey
	use({
		"max397574/which-key.nvim",
		config = function()
			require("user.whichkey").setup()
		end,
		event = "BufWinEnter",
	})

	-- alpha dashboard
	use({
		"goolord/alpha-nvim",
		config = function()
			require("user.alpha").setup()
		end,
	})

	-- toggleterm
	use({
		"akinsho/toggleterm.nvim",
		tag = "v2.*",
		config = function()
			-- require("toggleterm").setup()
			require("user.toggleterm").setup()
		end,
	})

	-- better buffer delete
	use("famiu/bufdelete.nvim")

	-- adds indent text object
	use("michaeljsmith/vim-indent-object")

	-- adds surroundings text object
	use("tpope/vim-surround")

	-- shows indent lines & current indent
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	})

	-- highlight color codes in editor
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	})

	-- quick motions with 's' key
	use("ggandor/lightspeed.nvim")

	-- smooth scrolling & other scrolling behaviors
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})

	-- create searchable to do comments
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})

	-- enable repeating with supported plugins
	use("tpope/vim-repeat")

	-- List of diagnostics
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	})

	-- preview markdown in browser with command
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- illuminate other uses of a word under cursor
	use({
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				delay = 150,
				filetypes_denylist = {
					"NvimTree",
					"alpha",
				},
			})
		end,
	})

	-- run snippets of code in editor
	use({ "michaelb/sniprun", run = "bash ./install.sh" })

	-- speed up neovim startup time
	use("lewis6991/impatient.nvim")

	-- zen mode
	-- TODO: add keybinds in which key
	use({
		"Pocco81/true-zen.nvim",
		config = function()
			require("true-zen").setup()
		end,
	})

	-- typescript helper functions
	use({
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("typescript").setup({
				disable_commands = false, -- prevent the plugin from creating Vim commands
				debug = false, -- enable debug logging for commands
				go_to_source_definition = {
					fallback = true, -- fall back to standard LSP definition on failure
				},
			})
		end,
	})

	-- treesitter symbols outline
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("user.symbols-outline").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
