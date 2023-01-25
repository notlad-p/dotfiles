-- nvim-tree.lua : nvim-neo-tree/neo-tree.nvim
-- lightspeed.nvim : ggandor/leap.nvim
-- bufdelete.nvim : mini.bufremove
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

  -- quick motions with 's' key
  "ggandor/lightspeed.nvim",

  -- whichkey
  {
    "max397574/which-key.nvim",
    config = function()
      require("user.whichkey").setup()
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

  -- better buffer delete
  "famiu/bufdelete.nvim",

  -- List of diagnostics
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
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

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    config = function()
      -- require("toggleterm").setup()
      require("user.toggleterm").setup()
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

  -- smooth scrolling & other scrolling behaviors
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  },
}
