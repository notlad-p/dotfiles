return {
  "stevearc/conform.nvim",
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
