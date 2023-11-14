return {
  -- treesitter styntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    keys = {
      {
        "<leader>H",
        function()
          local result = vim.treesitter.get_captures_at_cursor(0)
          print(vim.inspect(result))
        end,
        desc = "Get hl under cursor",
      },
    },
    opts = {
      ensure_installed = {
        "html",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "css",
        "java",
        "lua",
        "python",
        "help",
        "svelte",
        "query",
        "regex",
        "bash",
        "markdown",
        "markdown_inline",
        "vim",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
      -- for nvim-ts-autotag plugin
      autotag = {
        enable = true,
      },
      -- for nvim-ts-context-commentstring plugin
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- require("user.treesitter").config()
    end,
  },

  "nvim-treesitter/playground",
}
