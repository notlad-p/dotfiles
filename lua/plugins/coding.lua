-- windwp/nvim-autopairs : mini.pairs
-- tpope/vim-surround : nvim-surround
-- michaeljsmith/vim-indent-object : mini.ai : nvim-treesitter-textobjects
return {
  -- comments
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment", mode = "v" },
    },
    opts = {
      pre_hook = function()
        return vim.bo.commentstring
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

  -- better buffer navigation
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    opts = {
      save_on_toggle = false,
    },
    keys = {
      { "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>', desc = "Add harpoon mark" },
      { "<leader>me", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = "Toggle harpoon menu" },
      { "<leader>ma", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', desc = "Goto file 1" },
      { "<leader>ms", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', desc = "Goto file 2" },
      { "<leader>md", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', desc = "Goto file 3" },
      { "<leader>mf", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', desc = "Goto file 4" },
    },
  },

  -- adds surroundings text object
  "tpope/vim-surround",

  -- adds indent text object
  "michaeljsmith/vim-indent-object",
}
