local M = {}

-- lsp keybinds
local buffer_mappings = {
  normal_mode = {
    ["K"] = { vim.lsp.buf.hover, "Show hover" },
    ["gd"] = { vim.lsp.buf.definition, "Go to Definition" },
    ["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
    ["gr"] = { vim.lsp.buf.references, "Go to references" },
    ["gI"] = { vim.lsp.buf.implementation, "Go to Implementation" },
    ["gs"] = { vim.lsp.buf.signature_help, "Show signature help" },
    ["gl"] = {
      function()
        vim.diagnostic.open_float(0)
      end,
      "Show line diagnostics",
    },
    ["gt"] = { require("plugins.lsp.format").toggle, "Toggle format on save" },
    -- ['<leader>mo'] = { require("typescript").actions.organizeImports, "ORGANIZE" }
  },
  insert_mode = {},
  visual_mode = {},
}

-- typescript mappings
local ts_mappings = {
  normal_mode = {
    ["<leader>ja"] = { require("typescript").actions.addMissingImports, "Add missing imports" },
    ["<leader>jo"] = { require("typescript").actions.organizeImports, "Organize imports" },
    ["<leader>jr"] = { require("typescript").actions.removeUnused, "Remove unused variables" },
    ["<leader>jf"] = { require("typescript").actions.fixAll, "Fix all" },
  },
  insert_mode = {},
  visual_mode = {},
}

local function add_lsp_buffer_keybindings(bufnr, keys)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  -- loops through modes & mappings and adds them
  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(keys[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

-- Funciton run on lsp attach
M.on_attach = function(client, bufnr)
  add_lsp_buffer_keybindings(bufnr, buffer_mappings)

  if client.name == "tsserver" then
    add_lsp_buffer_keybindings(bufnr, ts_mappings)
  end
end

return M
