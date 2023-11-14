local conditions = {
  -- don't show if window width is less than 70
  hide_in_width = function()
    return vim.fn.winwidth(0) > 70
  end,
}

local function fg(name)
  local hl = vim.api.nvim_get_hl_by_name(name, true)
  return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
end

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

-- list registered providers from null-ls
local list_registered_providers_names = function(filetype)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

local function list_registered(filetype, method)
  local registered_providers = list_registered_providers_names(filetype)

  return registered_providers[method] or {}
end

-- components to show in status line
local M = {
  -- mode indicator on left side of status line
  mode = {
    function()
      return "󰠖 "
    end,
    -- TODO: figure out why two of the right characters are being rendered?
    -- separator = { left = "", right = "" },
    padding = { left = 1, right = 1 },
    color = {},
    cond = nil,
  },
  -- current git branch
  branch = {
    "b:gitsigns_head",
    icon = " ",
    color = { gui = "bold" },
    -- separator = { left = "", right = " " },
    cond = conditions.hide_in_width,
  },
  diff = {
    "diff",
    source = diff_source,
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
    color = fg "String",
    cond = conditions.hide_in_width,
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
    color = fg "Normal",
    cond = conditions.hide_in_width,
  },
}

return M
