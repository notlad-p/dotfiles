return {
  -- lualine status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    event = "BufWinEnter",
    opts = function(plugin)
      local components = require "plugins.lualine.components"
      return {

        options = {
          theme = "auto",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = { "alpha", "Outline", "lazy", "dashboard" } },
        },
        --     |   | ﰧ  ﮆ
        sections = {
          lualine_a = {
            components.mode,
          },
          lualine_b = {
            components.branch,
          },
          lualine_c = {
            {
              'filetype',
              icon_only = true,
              padding = {
                left = 1,
                right = 0,
              },
              separator = '',
            },
            "filename",
            components.diff,
          },
          lualine_x = {
            components.diagnostics,
            components.lsp,
            components.treesitter,
            "location"
          },
          lualine_y = {},
          lualine_z = {},
        },
        -- extensions = { "nvim-tree", "neo-tree" }, -- shows jarring filepath indicator when enabled
      }
    end,
  },
}
