return {
  -- alpha dashboard
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require "alpha.themes.dashboard"

      dashboard.section.header.val = require "plugins.alpha.header"

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", "<CMD>Telescope find_files<CR>"),
        dashboard.button("n", "  New File", "<CMD>ene!<CR>"),
        dashboard.button("p", "  Projects", "<CMD>Telescope projects<CR>"),
        dashboard.button("r", "  Recently Files", "<CMD>Telescope oldfiles<CR>"),
        dashboard.button("t", "  Find Text", "<CMD>Telescope live_grep<CR>"),
        dashboard.button("s", "  Restore Last Session", "<CMD>SessionRestore<CR>"),
        dashboard.button("c", "  Configuration", "<CMD>edit ~/.config/nvim/init.lua<CR>"),
      }

      -- hl (highlight) changes color
      -- based on highlight groups:
      -- https://neovim.io/doc/user/syntax.html#group-name
      dashboard.section.header.opts.hl = "Special"
      -- dashboard.section.buttons.opts.hl = "Include" - Not implemented yet?
      dashboard.section.footer.opts.hl = "Type"
      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)

      -- display footer after lazy has started to show startup time
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local startuptime = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          dashboard.section.footer.val = "    "
            .. stats.count
            .. " plugins | 龍 "
            .. startuptime
            .. "ms startup |   v"
            .. vim.version().major
            .. "."
            .. vim.version().minor
            .. "."
            .. vim.version().patch
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
