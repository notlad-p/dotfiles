-- windwp/nvim-autopairs : mini.pairs
-- tpope/vim-surround : mini.surround
-- michaeljsmith/vim-indent-object : mini.ai
-- numToStr/Comment.nvim : mini.comment
return {
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
