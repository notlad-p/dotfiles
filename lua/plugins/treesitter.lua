return {
  -- treesitter styntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      ensure_installed = {
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
