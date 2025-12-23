return {
  -- {
  --   "folke/sidekick.nvim",
  --   opts = {
  --     nes = { enabled = false },
  --   },
  --   keys = {
  --     {
  --       "<leader>an",
  --
  --       function()
  --         require("sidekick.nes").toggle()
  --       end,
  --       desc = "Toggle Sidekick NES",
  --     },
  --   },
  -- },

  {
    "yetone/avante.nvim",
    opts = {
      providers = {
        copilot = {
          model = "gpt-5-mini",
        },
      },

      behaviour = {
        auto_approve_tool_permissions = false,
      },
    },
    keys = {
      { "<leader>aL", "<cmd>AvanteClear<CR>", desc = "Clear Avante Chat" },
      { "<leader>ae", "<cmd>AvanteEdit<CR>", mode = "v", desc = "Edit Avante" },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = false,
        keymap = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = true },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
