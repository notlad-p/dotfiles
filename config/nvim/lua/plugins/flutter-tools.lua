return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  -- TODO: only load this plugin in flutter projects
  --
  -- enabled = function()
  --   return vim.fn.findfile("pubspec.yaml", vim.fn.getcwd())
  -- end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  opts = {
    dev_log = {
      enabled = true,
      filter = nil, -- optional callback to filter the log
      -- takes a log_line as string argument; returns a boolean or nil;
      -- the log_line is only added to the output if the function returns true
      notify_errors = false, -- if there is an error whilst running then notify the user
      open_cmd = "15split", -- command to use to open the log buffer
      focus_on_open = true, -- focus on the newly opened log window
    },
  },
  keys = {
    { "<leader>ltr", "<cmd>FlutterRun<CR>", desc = "Flutter Run" },
    { "<leader>ltR", "<cmd>FlutterRun --release<CR>", desc = "Flutter Run Release" },
    { "<leader>ltc", "<cmd>FlutterRun -d chrome<CR>", desc = "Flutter Run (Chrome)" },
    { "<leader>ltC", "<cmd>FlutterRun -d chrome --release<CR>", desc = "Flutter Run Release (Chrome)" },
    { "<leader>ltl", "<cmd>FlutterLogToggle<CR>", desc = "Flutter Toggle Log" },
    { "<leader>ltq", "<cmd>FlutterQuit<CR>", desc = "Flutter Quit" },
  },
  config = true,
}
