return {
  -- plugin of helpers used by other plugins
  "nvim-lua/plenary.nvim",

  -- enable repeating with supported plugins
  "tpope/vim-repeat",

  -- preview markdown in browser with command
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- run snippets of code in editor
  { "michaelb/sniprun", build = "bash ./install.sh" },

  -- sessions
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_restore_enabled = false,
      pre_save_cmds = {
        function()
          -- if a blank buffer exists, remove it
          local buffers = vim.api.nvim_list_bufs()
          for _, buffer in ipairs(buffers) do
            if vim.api.nvim_buf_get_name(buffer) == "" then
              vim.api.nvim_command("bwipeout! " .. buffer)
            end
          end
        end,
      },
    },
  },

  -- OpenAI chat interface - for asking questions and messing around mainly
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  -- File explorer to edit filesystem like a normal buffer
  -- {
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("oil").setup()
  --   end,
  -- },
}
