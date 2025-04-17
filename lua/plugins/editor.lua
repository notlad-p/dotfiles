return {
  {
    "folke/which-key.nvim",
    opts_extend = { "" },
    opts = {
      preset = "helix",
      spec = {
        {
          mode = { "n", "v" },
          -- { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
          { "<leader><tab>", group = "tabs" },
          -- { "<leader>c", group = "code" },
          { "<leader>l", group = "lsp (code)" },
          { "<leader>L", group = "lazy" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find", mode = { "n" } },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>Q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },

          {
            "<leader>W",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          { "gx", desc = "Open with system app" },
        },
      },
    },
    -- config = function(_, opts)
    --   local wk = require("which-key")
    --   wk.setup(opts)
    -- end,
    -- keys = {},
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>cs", false },
      { "<leader>cS", false },

      { "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>lS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
    },
  },
}
