local trouble = require "trouble.providers.telescope"

return {
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>U", "<cmd>Telescope undo<cr>" } },
        config = function()
          require("telescope").load_extension "undo"
        end,
        desc = "Undo tree",
      },
    },
    keys = {
      -- file pickers
      { "<leader>f",  "<cmd>Telescope find_files<cr>",   desc = "Find file" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>",   desc = "Find file" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>",  desc = "Word under cursor" },
      { "<leader>st", "<cmd>Telescope live_grep<cr>",    desc = "Text" },

      -- vim pickers
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>",     desc = "Recent Files" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",     desc = "Commands" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",    desc = "Help tags" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",    desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",        desc = "Marks" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>",     desc = "Quickfix list" },
      { "<leader>sR", "<cmd>Telescope registers<cr>",    desc = "Registers" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",      desc = "Keymaps" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>",   desc = "Highlight groups" },

      -- git pickers
      { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        multi_icon = "⤞ ",
        file_ignore_patterns = { "node_modules" },
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
        layout_strategy = "center",
        sorting_strategy = "ascending",
        layout_config = {
          height = 0.35,
          width = 0.65,
          anchor = "S",
        },
        man_pages = {
          theme = "dropdown",
        },
        highlights = {
          theme = "dropdown",
        },
        registers = {
          theme = "dropdown",
        },
        keymaps = {
          theme = "dropdown",
        },
        -- Git Pickers
        git_branches = {
          theme = "dropdown",
        },
        -- LSP Pickers
        lsp_document_symbols = {
          theme = "dropdown",
        },
        diagnostics = {
          theme = "dropdown",
        },
      },
    },
  },

  -- session searcher
  {
    "rmagatti/session-lens",
    opts = { theme = "dropdown" },
    keys = {
      { "<leader>ss", "<cmd>Telescope session-lens search_session<cr>", desc = "Sessions" },
    },
  },
}
