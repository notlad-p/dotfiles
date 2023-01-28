local M = {}

function M.setup()
  local config = {
    -- Diagnostic virtual text (Text that apears at end of line when a diagnostic is detected)
    virtual_text = true,
    signs = {
      -- active = true,
      -- Diagnostic Icons
      active = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      },
    },
    -- underline diagnostics
    underline = true,
    -- don't update diagnostics in insert mode
    update_in_insert = false,
    severity_sort = true,
    -- floating diagnostic windows
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  -- loop signs and asign them in vim
  for _, sign in pairs(config.signs.active) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config(config)
end

return M
