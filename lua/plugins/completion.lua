return {
  -- completions
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("user.cmp").setup()
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",

  -- snippets
  "rafamadriz/friendly-snippets",
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = {
          "~/.config/nvim/snippets",
          "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
        },
      }
    end,
  },

  -- schemeas for autocompletion in files like `tsconfig.json` and `package.json`
  "b0o/SchemaStore.nvim",
}
