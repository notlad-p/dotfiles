return {
  {

    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- local border = {
      --   { "🭽", "FloatBorder" },
      --   { "▔", "FloatBorder" },
      --   { "🭾", "FloatBorder" },
      --   { "▕", "FloatBorder" },
      --   { "🭿", "FloatBorder" },
      --   { "▁", "FloatBorder" },
      --   { "🭼", "FloatBorder" },
      --   { "▏", "FloatBorder" },
      -- }
      -- keys[#keys + 1] = {
      --   "K",
      --   function()
      --     return vim.lsp.buf.hover({ border = border })
      --   end,
      --   desc = "Hover",
      -- }

      -- remap 'c' keymaps to 'l'
      for key, value in pairs(keys) do
        local isCodeMap = string.find(value[1], "<leader>c")

        if isCodeMap then
          keys[key][1] = string.gsub(keys[key][1], "<leader>c", "<leader>l")
        end
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    keys = { { "<leader>cm", false }, { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
  },
}
