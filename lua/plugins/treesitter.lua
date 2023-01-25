return {
  -- treesitter styntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("user.treesitter").config()
    end,
  },

  -- treesitter symbols outline
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("user.symbols-outline").setup()
    end,
  },

  "nvim-treesitter/playground",
}
