-- windwp/nvim-autopairs : mini.pairs
-- tpope/vim-surround : mini.surround
-- michaeljsmith/vim-indent-object : mini.ai
-- numToStr/Comment.nvim : mini.comment
return {
  -- comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
    },
    config = function(_, opts)
      require("Comment").setup(opts)
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

  -- adds surroundings text object
  "tpope/vim-surround",

  -- adds indent text object
  "michaeljsmith/vim-indent-object",

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
}
