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
    config = function()
      require("user.autosession").setup()
    end,
  },
  -- session searcher
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("session-lens").setup()
    end,
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
