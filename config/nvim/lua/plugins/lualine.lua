return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              icon = "",
              separator = { left = "", right = " " },
              -- padding = { right = 20 },
              cond = nil,
            },
          },
          lualine_b = {
            {
              "branch",
              separator = { left = "", right = " " },
            },
            {
              "diff",
              separator = { left = "", right = " " },
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },

          lualine_c = {
            -- LazyVim.lualine.root_dir(),
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },

          lualine_x = {
            {
              function()
                local current_bufnr = vim.api.nvim_get_current_buf()
                local buf_clients = vim.lsp.get_clients({ bufnr = current_bufnr })
                local buf_client_names = {}

                -- LSP clients
                -- local lsp_str = " "
                for _, client in pairs(buf_clients) do
                  table.insert(buf_client_names, client.name)
                end

                -- linters
                local has_lint, lint = pcall(require, "lint")
                if has_lint then
                  local buf_linters = lint.linters_by_ft[vim.bo.filetype]
                  if buf_linters then
                    vim.list_extend(buf_client_names, buf_linters)
                  end
                end

                -- formatters
                local has_conform, conform = pcall(require, "conform")
                if has_conform then
                  local buf_formatters = conform.list_formatters()

                  for _, formatter in pairs(buf_formatters) do
                    table.insert(buf_client_names, formatter.name)
                  end
                end

                if #buf_client_names == 0 then
                  return "LSP Inactive"
                else
                  return "󰆼 " .. table.concat(buf_client_names, ", ")
                end
              end,
              color = function()
                return { fg = Snacks.util.color("LuaLineGrey") }
              end,
            },

            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },

            Snacks.profiler.status(),

            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
            -- {
            --   function() return require("noice").api.status.mode.get() end,
            --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            --   color = function() return { fg = Snacks.util.color("Constant") } end,
            -- },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = function()
                return { fg = Snacks.util.color("Debug") }
              end,
            },
          },
          lualine_y = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              separator = { left = "", right = "" },
              padding = { left = 1, right = 2 },
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
            -- space,
            -- space,
          },
          lualine_z = {
            {
              "location",
              padding = 0,
              separator = { left = "", right = " " },
            },
            {
              "progress",
              separator = "",
              fmt = function(percent)
                return "(" .. percent .. ")"
              end,
            },
          },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
}
