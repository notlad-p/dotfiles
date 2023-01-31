-- indent-blankline / vim-indent-object : mini-indentscope
return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    keys = {
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle next buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle previous buffer" },
      { "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
      { "<leader>bt", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pinned buffer" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Jump buffer" },
      { "<leader>bf", "<cmd>Telescope buffers<cr>", "Find buffer" },
      { "<leader>be", "<cmd>BufferLinePickClose<cr>", "Pick buffer to close" },
      { "<leader>bj", "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      { "<leader>bk", "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
      { "<leader>bd", "<cmd>BufferLineSortByRelativeDirectory<cr>", "Sort by relative directory" },
      { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
      { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    },
    opts = function()
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
          separator_style = "thin", -- "slant" | "padded_slant" | "thick" | "thin" | { "any", "any" },
          always_show_bufferline = false,
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

  -- zen mode
  -- TODO: add keybinds in which key
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup()
    end,
  },
}
