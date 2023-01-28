local M = {}

-- run all core configs
M.setup = function()
  require "core.options"
  require "core.keymaps"
  require("core.autocmds").setup()
end

return M
