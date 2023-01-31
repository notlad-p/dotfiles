-- windwp/nvim-autopairs : mini.pairs
-- tpope/vim-surround : nvim-surround
-- michaeljsmith/vim-indent-object : mini.ai : nvim-treesitter-textobjects
return {
  -- comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment", mode = "v" },
    },
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
  -- TODO: insert '()' after functions and methods using cmp + nvim-autopairs?
  -- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      fast_wrap = {},
    },
  },
  "windwp/nvim-ts-autotag",

  -- adds surroundings text object
  "tpope/vim-surround",

  -- adds indent text object
  "michaeljsmith/vim-indent-object",
}
