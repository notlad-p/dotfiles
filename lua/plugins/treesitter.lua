return {
  -- treesitter styntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
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
        "vimdoc",
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
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- require("user.treesitter").config()
    end,
  },

  "JoosepAlviste/nvim-ts-context-commentstring",
  "nvim-treesitter/playground",
}
