return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>qs", false},
    { "<leader>qS", false},
    { "<leader>ql", false},
    { "<leader>qd", false},

    { "<leader>Qs", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>QS", function() require("persistence").select() end,desc = "Select Session" },
    { "<leader>Ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>Qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
  },
  {
    "snacks.nvim",
    -- preset = "ivy_split",
    opts = {

      picker = {

        -- layout = {
        --   backdrop = false,
        --   row = 1,
        --   width = 0.4,
        --   min_width = 80,
        --   height = 0.8,
        --   border = "none",
        --   box = "vertical",
        --   { win = "preview", title = "{preview}", height = 0.4, border = "rounded" },
        --   {
        --     box = "vertical",
        --     border = "rounded",
        --     title = "{title} {live} {flags}",
        --     title_pos = "center",
        --     { win = "input", height = 1, border = "bottom" },
        --     { win = "list", border = "none" },
        --   },
        -- },
      },
    },
  },
}
