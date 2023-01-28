local M = {}

-- enable format on save by default
M.format_on_save = true

-- toggle format on save
M.toggle = function()
  M.format_on_save = not M.format_on_save

  -- TODO: add notification that format on save has been enabled/disabled
  -- https://github.com/LazyVim/LazyVim/blob/40d363cf3f468a1cc4ea482eaabbd5c7e224f397/lua/lazyvim/plugins/lsp/format.lua#L9
end

M.format = function()
  local buffer = vim.api.nvim_get_current_buf()
  local filetype = vim.bo.filetype
  local sources = require "null-ls.sources"
  local method = require("null-ls").methods.FORMATTING
  local available_sources = sources.get_available(filetype, method)

  vim.lsp.buf.format {
    bufnr = buffer,
    filter = function(client)
      if #available_sources > 0 then
        return client.name == "null-ls"
      end

      return client.name ~= "null-ls"
    end,
  }
end

M.on_attach = function(client, buffer)
  local augroup = vim.api.nvim_create_augroup("LspFormatOnSave", {})
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = buffer,
      callback = function()
        if M.format_on_save then
          M.format()
        end
      end,
    })
  end
end

return M
