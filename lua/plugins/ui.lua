-- indent-blankline / vim-indent-object : mini-indentscope
return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    keys = {
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle next buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle previous buffer" },
      { "<leader>Bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
      { "<leader>Bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
      { "<leader>Bt", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pinned buffer" },
      { "<leader>Bp", "<cmd>BufferLinePick<cr>", desc = "Jump buffer" },
      { "<leader>Bf", "<cmd>Telescope buffers<cr>", "Find buffer" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", "Find buffer" },
      { "<leader>Be", "<cmd>BufferLinePickClose<cr>", "Pick buffer to close" },
      { "<leader>Bj", "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      { "<leader>Bk", "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
      { "<leader>Bd", "<cmd>BufferLineSortByRelativeDirectory<cr>", "Sort by relative directory" },
      { "<leader>BD", "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
      { "<leader>BL", "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    },
    opts = function()
      local bufferline = require("bufferline")

      return {
        options = {
          themable = false, -- whether or not the highlights for this plugin can be overriden.
          name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match "%.md" then
              return vim.fn.fnamemodify(buf.name, ":t:r")
            end
          end,
          diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc"
          diagnostics_indicator = function(num, _, diagnostics, _)
            local result = {}
            local symbols = { error = "", warning = "", info = "" }
            for name, count in pairs(diagnostics) do
              if symbols[name] and count > 0 then
                table.insert(result, symbols[name] .. " " .. count)
              end
            end
            result = table.concat(result, " ")
            return #result > 0 and result or ""
          end,
          always_show_bufferline = false,
          separator_style = { "|", "|" }, -- "slant" | "padded_slant" | "thick" | "thin" | { "any", "any" },
          style_preset = bufferline.style_preset.no_italic,
          offsets = {
            { filetype = "NvimTree", text = "Explorer", text_align = "center", padding = 1 },
            {
              filetype = "neo-tree",
              text = "Explorer",
              highlight = "Directory",
              text_align = "center",
            },
          },
          persist_buffer_sort = false,
          sort_by = "insert_after_current",
          groups = {
            items = {
              require("bufferline.groups").builtin.pinned:with { icon = "" },
            },
          },
        },
      }
    end,
    event = "BufWinEnter",
  },

  -- shows indent lines & current indent
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  -- improve default vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = {
        prompt_align = "center",
        relative = "win",
        win_options = {
          winblend = 5,
        },
      },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
  },

  -- noicer ui for cmdline, messages, & popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        format = {
          cmdline = { icon = " " },
        },
      },
      messages = {
        view = "mini",
      },
      lsp = {
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        message = {
          enabled = true,
        },
        -- disable lsp messages, it's distracting
        progress = { enabled = false },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      routes = {
        -- show `recording @` messages
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true,
        desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,
        expr = true, desc = "Scroll backward" },
    },
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 3000,
    },
  },

  { "MunifTanjim/nui.nvim", lazy = true },

  -- zen mode
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup()
    end,
  },
}
