local prettier = { "prettierd" }

return {
  "stevearc/conform.nvim",
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      vue = prettier,
      css = prettier,
      scss = prettier,
      less = prettier,
      html = prettier,
      json = prettier,
      jsonc = prettier,
      yaml = prettier,
      markdown = prettier,
      ["markdown.mdx"] = prettier,
      graphql = prettier,
      handlebars = prettier,
    },
  },
  keys = {
    {
      "<leader>cF",
      false,
    },
    {
      "<leader>lF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
}
