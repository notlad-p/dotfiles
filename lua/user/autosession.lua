local M = {}

M.setup = function()
  require("auto-session").setup {
    log_level = "error",
    auto_restore_enabled = false,
    pre_save_cmds = {
      function()
        -- if a blank buffer exists, remove it
        local buffers = vim.api.nvim_list_bufs()
        for _, buffer in ipairs(buffers) do
          if vim.api.nvim_buf_get_name(buffer) == "" then
            vim.api.nvim_command("bwipeout! " .. buffer)
          end
        end
      end,
    },
  }
end

return M
