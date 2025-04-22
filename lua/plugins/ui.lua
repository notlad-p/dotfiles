return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        -- show `recording @` messages
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
    },
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      lazy_load = true,
      user_default_options = {
        names = false,
        css = true,
        tailwind = "both",
        tailwind_opts = {
          update_names = true,
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    keys = {

      -- move buffers
      { "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
      --replace delete left/right command
      { "<leader>br", false },
      { "<leader>bL", "<cmd>BufferLineCloseRight<cr>", desc = "Delete buffers to the Right" },
      { "<leader>bH", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete buffers to the Left" },
      -- sorting
      { "<leader>bse", "<cmd>BufferLineSortByExtension<CR>", desc = "sort by extension" },
      { "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", desc = "sort by directory" },
      { "<leader>bst", "<cmd>BufferLineSortByTabs<CR>", desc = "sort by tabs" },
      {
        "<leader>bsm",
        function()
          require("bufferline").sort_by(function(buffer_a, buffer_b)
            -- @type bufferline.Buffer
            local test = buffer_a
            print(buffer_a)

            for key, buffer_attr in pairs(buffer_a) do
              -- print(key .. ": " .. buffer_attr)
              print(key)
              -- print(buffer_attr)
              -- table.insert(, client.name)
            end

            local modified_a = vim.fn.getftime(buffer_a.path)
            local modified_b = vim.fn.getftime(buffer_b.path)
            return modified_a > modified_b
          end)
        end,
        desc = "sort by modified time",
      },
      {
        "<leader>bsi",
        function()
          require("bufferline").sort_by(function(buffer_a, buffer_b)
            local modified_a = buffer_a.id
            local modified_b = buffer_b.id
            return modified_a > modified_b
          end)
        end,
        desc = "sort by buffer id",
      },
    },
  },

  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim",
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>e",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi explorer (current file)",
        remap = true,
      },
      {
        -- Open in the current working directory
        "<leader><c-e>",
        "<cmd>Yazi cwd<cr>",
        desc = "Open yazi explorer (working directory)",
      },
      {
        "<leader><c-y>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      -- keymaps = {
      --   show_help = "<f1>",
      -- },
      future_features = {
        -- Neovim nightly 0.11 has deprecated `termopen` in favor of `jobstart`
        -- (https://github.com/neovim/neovim/pull/31343). By default on nightly,
        -- this option is `false` and `jobstart` is used. Some users have
        -- reported issues with this, and can set this to `true` to keep using
        -- the old `termopen` for the time being.
        nvim_0_10_termopen_fallback = true,

        -- By default, this is `true`, which means yazi.nvim processes events
        -- before yazi has been closed. If this is `false`, events are processed
        -- in a batch when the user closes yazi. If this is `true`, events are
        -- processed immediately.
        process_events_live = true,
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    -- init = function()
    --   -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    --   -- vim.g.loaded_netrw = 1
    --   vim.g.loaded_netrwPlugin = 1
    -- end,
  },
}
