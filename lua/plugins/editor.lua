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
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute { toggle = true }
        end,
        desc = "File tree",
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

  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      {
        "-",
        "<CMD>Oil<CR>",
        desc = "Open parent directory",
      },
    },
    -- Optional dependencies
    dependencies = { "kyazdani42/nvim-web-devicons" },
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
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = true,
      },
      window = { border = "single" },
    },
    config = function(_, opts)
      local which_key = require "which-key"
      which_key.setup(opts)

      which_key.register {
        mode = { "n", "v" },
        ["<leader>B"] = { name = "Buffers" },
        ["<leader>g"] = { name = "Git" },
        ["<leader>l"] = { name = "LSP" },
        ["<leader>s"] = { name = "Search" },
        ["<leader>x"] = { name = "Trouble" },
        ["<leader>n"] = { name = "Noice" },
        ["<leader>m"] = { name = "Harpoon" },
        ["<leader><tab>"] = { name = "Tabs" },
        ["]"] = { name = "Next" },
        ["["] = { name = "Prev" },
      }
    end,
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      signcolumn = true,
      numhl = true,
    },
    keys = {
      { "]h",         "<cmd>lua require 'gitsigns'.next_hunk()<cr>",           desc = "Jump next hunk" },
      { "[h",         "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",           desc = "Jump prev hunk" },
      { "<leader>gB", "<cmd>lua require 'gitsigns'.blame_line()<cr>",          desc = "Blame line" },
      { "<leader>gD", "<cmd>lua require 'gitsigns'.toggle_deleted()<cr>",      desc = "Toggle deleted lines" },
      { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",        desc = "Reset buffer" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>",                       desc = "Checkout branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",                        desc = "Checkout commit" },
      { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",           desc = "Jump next hunk" },
      { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",           desc = "Jump prev hunk" },
      { "<leader>go", "<cmd>Telescope git_status<cr>",                         desc = "Open changed file" },
      { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>", desc = "Preview hunk" },
      { "<leader>gq", "<cmd>lua require 'gitsigns'.setqflist()<cr>",           desc = "Quickfix list hunks" },
      { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",          desc = "Reset hunk" },
      { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",          desc = "Stage hunk" },
      { "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>",          desc = "Stage buffer" },
      { "<leader>gt", "<cmd>lua require 'gitsigns'.diffthis()<cr>",            desc = "View file diff" },
      { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",     desc = "Undo stage hunk" },
      {
        "<leader>gC",
        "<cmd>Telescope git_bcommits<cr>",
        desc = "Checkout commit(for current file)",
      },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
    },
  },

  -- illuminate other uses of a word under cursor
  {
    "RRethy/vim-illuminate",
    event = "BufWinEnter",
    opts = {
      delay = 150,
      filetypes_denylist = {
        "NvimTree",
        "alpha",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    keys = {
      {
        "]]",
        function()
          require("illuminate").goto_next_reference(false)
        end,
        desc = "Next reference",
      },
      {
        "[[",
        function()
          require("illuminate").goto_prev_reference(false)
        end,
        desc = "Prev Reference",
      },
    },
  },

  -- better buffer delete
  "famiu/bufdelete.nvim",

  -- List of diagnostics
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Toggle trouble" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document diagnostics" },
      { "<leader>xD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>",        desc = "LSP references" },
      { "<leader>xf", "<cmd>TroubleToggle lsp_definitions<cr>",       desc = "LSP definitions" },
      { "<leader>xt", "<cmd>TroubleToggle lsp_type_definitions<cr>",  desc = "LSP type definitions" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix items" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location list items" },
    },
    config = function()
      require("trouble").setup()
    end,
  },

  -- create searchable to do comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufRead",
    keys = {
      { "<leader>sT", "<cmd>TodoTelescope theme=dropdown<cr>", desc = "Todos" },
      { "<leader>xT", "<cmd>TodoTrouble<cr>",                  desc = "Todos" },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
    },
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { [[<c-\>]], "<cmd>ToggleTerm<CR>", desc = "Toggle floating term", mode = { "i", "n" } },
    },
    version = "v2.*",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,       -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true,   -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = false,
      -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
      direction = "float",
      close_on_exit = true,    -- close the terminal window when the process exits
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
  },

  -- highlight color codes in editor
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
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

  {
    "ziontee113/icon-picker.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      disable_legacy_commands = true,
    },
  },
}
