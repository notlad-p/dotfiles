local M = {}

M.setup = function()
  local autocmds = {
    {
      "TextYankPost",
      {
        group = "_general_settings",
        pattern = "*",
        desc = "Highlight text on yank",
        callback = function()
          vim.highlight.on_yank { higroup = "Search", timeout = 200 }
        end,
      },
    },

    {
      "FileType",
      {
        group = "_filetype_settings",
        pattern = { "gitcommit", "markdown" },
        desc = "spell check gitcommit and markdow files",
        command = "setlocal  spell",
      },
    },

    {
      "ColorScheme",
      {
        group = "_illuminate_settings",
        pattern = "*",
        desc = "Highlighting for vim-illuminate",
        callback = function()
          vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true, underline = false })

          vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#455574" })

          vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#455574" })
        end,
      },
    },
  }

  M.define_autocmds(autocmds)
end

--- Create autocommand groups based on the passed definitions
--- Also creates the augroup automatically if it doesn't exist
---@param definitions table contains a tuple of event, opts, see `:h nvim_create_autocmd`
function M.define_autocmds(definitions)
  for _, entry in ipairs(definitions) do
    local event = entry[1]
    local opts = entry[2]
    if type(opts.group) == "string" and opts.group ~= "" then
      local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
      if not exists then
        vim.api.nvim_create_augroup(opts.group, {})
      end
    end
    vim.api.nvim_create_autocmd(event, opts)
  end
end

return M
