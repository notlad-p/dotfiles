-- lightspeed.nvim : ggandor/leap.nvim
-- bufdelete.nvim : mini.bufremove
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      -- "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
      "MunifTanjim/nui.nvim",
    },
    -- TODO: have <leader>e always open in root file
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua#L13
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute { toggle = true }
        end,
      },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    opts = {
      source_selector = {
        winbar = true,
      },
      window = {
        width = 35,
      },
      filesystem = {
        follow_current_file = true,
        filtered_items = {
          hide_by_name = {
            "node_modules",
          },
          always_show = {
            ".gitignore",
          },
        },
      },
    },
  },

  -- quick motions with 's' key
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      local leap = require "leap"
      leap.add_default_mappings(true)
    end,
  },

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
    cmd = { "ToggleTerm", "TermExec" },
    version = "v2.*",
    opts = {
      size = 20,
      open_mapping = [[<c-t>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = false,
      -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      -- CHANGE THIS IF NOT USING FISH SHELL
      shell = "/usr/bin/fish", -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = "curved",
        -- width = <value>,
        -- height = <value>,
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    keys = {
      { "<c-t>", "<cmd>ToggleTerm<CR>", mode = { "i", "n" } },
    },
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
