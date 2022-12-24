local conditions = {
  -- don't show if window width is less than 70
  hide_in_width = function()
    return vim.fn.winwidth(0) > 70
  end,
}

-- colors for status line
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function list_registered(filetype, method)
  local services = require "user.lsp.null-ls"
  local registered_providers = services.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

-- components to show in status line
local M = {
  -- mode indicator on left side of status line
  -- 
  mode = {
    function()
      return "﫜"
    end,
    separator = { left = "", right = " " },
    padding = { left = 1, right = 0 },
    color = {},
    cond = nil,
  },
  -- current git branch
  branch = {
    "b:gitsigns_head",
    icon = " ",
    color = { gui = "bold" },
    separator = { left = "", right = " " },
    cond = conditions.hide_in_width,
  },
  filename = {
    "filename",
    color = {},
    cond = nil,
  },
  diff = {
    "diff",
    source = diff_source,
    -- separator = { left = "", right = " " },
    symbols = { added = "  ", modified = " ", removed = " " },
    diff_color = {
      added = "DiffAdded",
      modified = "DiffModified",
      removed = "DiffDelete",
    },
    cond = nil,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    cond = conditions.hide_in_width,
  },
  treesitter = {
    function()
      local b = vim.api.nvim_get_current_buf()
      if next(vim.treesitter.highlighter.active[b]) then
        return ""
      end
      return ""
    end,
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  },
  filetype = { "filetype", cond = conditions.hide_in_width },
  scrollbar = {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = { fg = colors.yellow, bg = colors.bg },
    cond = nil,
  },
  lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      local null_ls = require "null-ls"

      -- add formatter
      -- local formatters = require("lvim.lsp.null-ls.formatters")
      local formatters_method = null_ls.methods.FORMATTING
      local supported_formatters = list_registered(buf_ft, formatters_method)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters_method = null_ls.methods.DIAGNOSTICS
      -- local linters = require("lvim.lsp.null-ls.linters")
      local supported_linters = list_registered(buf_ft, linters_method)
      vim.list_extend(buf_client_names, supported_linters)

      local unique_client_names = vim.fn.uniq(buf_client_names)
      return table.concat(unique_client_names, ", ")
    end,
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
  },
  location = { "location" },
}

return M
