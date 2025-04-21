return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        -- show `recording @` messages
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    -- TODO: add sort buffers keys
    keys = {

      -- move buffers
      { "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
      --replace delete left/right command
      { "<leader>br", false },
      { "<leader>bL", "<cmd>BufferLineCloseRight<cr>", desc = "Delete buffers to the Right" },
      { "<leader>bH", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete buffers to the Left" },
      -- sorting
      { "<leader>bse", "<cmd>BufferLineSortByExtension<CR>", desc = "sort by extension" },
      { "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", desc = "sort by directory" },
      { "<leader>bst", "<cmd>BufferLineSortByTabs<CR>", desc = "sort by tabs" },
      {
        "<leader>bsm",
        function()
          require("bufferline").sort_by(function(buffer_a, buffer_b)
            -- @type bufferline.Buffer
            local test = buffer_a
            print(buffer_a)

            for key, buffer_attr in pairs(buffer_a) do
              -- print(key .. ": " .. buffer_attr)
              print(key)
              -- print(buffer_attr)
              -- table.insert(, client.name)
            end

            local modified_a = vim.fn.getftime(buffer_a.path)
            local modified_b = vim.fn.getftime(buffer_b.path)
            return modified_a > modified_b
          end)
        end,
        desc = "sort by modified time",
      },
      {
        "<leader>bsi",
        function()
          require("bufferline").sort_by(function(buffer_a, buffer_b)
            local modified_a = buffer_a.id
            local modified_b = buffer_b.id
            return modified_a > modified_b
          end)
        end,
        desc = "sort by buffer id",
      },
    },
  },
}
