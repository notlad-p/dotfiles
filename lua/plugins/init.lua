return {
  -- File tree with icons
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("user.nvimtree").setup()
    end,
  },

  -- onedark theme
  -- use({
  -- 	"navarasu/onedark.nvim",
  -- 	as = "onedark",
  -- 	config = function()
  -- 		local onedark = require("onedark")
  --
  -- 		onedark.setup({
  -- 			style = "deep",
  -- 			-- transparent = true,
  -- 		})
  --
  -- 		onedark.load()
  -- 	end,
  -- })

  -- use { "Everblush/everblush.nvim", as = "everblush" }
  -- use { "~/projects/yoru", as = "yoru" }
  {
    dir = "~/projects/lad-schemes.nvim",
    name = "lad-schemes",
    config = function()
      require("lad-schemes").setup {
        scheme = "gruvbox",
      }
    end,
  },

  -- treesitter styntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("user.treesitter").config()
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("user.bufferline").config()
    end,
    event = "BufWinEnter",
  },

  -- lualine status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    config = function()
      require("user.lualine").config()
    end,
    event = "BufWinEnter",
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufRead",
  },

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "williamboman/mason.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "nvim-lua/plenary.nvim",

  -- completions
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("user.cmp").setup()
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",

  -- snippets
  "rafamadriz/friendly-snippets",
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = {
          "~/.config/nvim/snippets",
          "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
        },
      }
    end,
  },

  -- autopairs / tags
  {
    "windwp/nvim-autopairs",
    config = function()
      require("user.autopairs").setup()
    end,
    event = "InsertEnter",
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup {
        autotag = {
          enable = true,
        },
      }
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("user.telescope").setup()
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make",
  },

  -- project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("user.comment").config()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  },

  -- whichkey
  {
    "max397574/which-key.nvim",
    config = function()
      require("user.whichkey").setup()
    end,
    event = "BufWinEnter",
  },

  -- alpha dashboard
  -- {
  --   "goolord/alpha-nvim",
  --   config = function()
  --     require("user.alpha").setup()
  --   end,
  -- },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    config = function()
      -- require("toggleterm").setup()
      require("user.toggleterm").setup()
    end,
  },

  -- better buffer delete
  "famiu/bufdelete.nvim",

  -- adds indent text object
  "michaeljsmith/vim-indent-object",

  -- adds surroundings text object
  "tpope/vim-surround",

  -- shows indent lines & current indent
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  -- highlight color codes in editor
  {
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
  },

  -- quick motions with 's' key
  "ggandor/lightspeed.nvim",

  -- smooth scrolling & other scrolling behaviors
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  },

  -- create searchable to do comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- enable repeating with supported plugins
  "tpope/vim-repeat",

  -- List of diagnostics
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },

  -- preview markdown in browser with command
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- illuminate other uses of a word under cursor
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure {
        delay = 150,
        filetypes_denylist = {
          "NvimTree",
          "alpha",
        },
      }
    end,
  },

  -- run snippets of code in editor
  { "michaelb/sniprun", build = "bash ./install.sh" },

  -- speed up neovim startup time
  "lewis6991/impatient.nvim",

  -- zen mode
  -- TODO: add keybinds in which key
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup()
    end,
  },

  -- typescript helper functions
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup {
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true, -- fall back to standard LSP definition on failure
        },
      }
    end,
  },

  -- treesitter symbols outline
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("user.symbols-outline").setup()
    end,
  },

  -- schemeas for autocompletion in files like `tsconfig.json` and `package.json`
  "b0o/schemastore.nvim",

  -- sessions
  {
    "rmagatti/auto-session",
    config = function()
      require("user.autosession").setup()
    end,
  },
  -- session searcher
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("session-lens").setup()
    end,
  },

  "rktjmp/lush.nvim",
  "rktjmp/shipwright.nvim",

  -- OpenAI chat interface - for asking questions and messing around mainly
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  "nvim-treesitter/playground",

  -- File explorer to edit filesystem like a normal buffer
  -- {
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("oil").setup()
  --   end,
  -- },
}
