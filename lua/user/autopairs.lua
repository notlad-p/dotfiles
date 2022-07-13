local M = {}

M.setup = function()
	require("nvim-autopairs").setup({
		check_ts = true,
		ts_config = {
			lua = { "string", "source" },
			javascript = { "string" },
			java = false,
		},
		---@usage check bracket in same line
		enable_check_bracket_line = true,
		---@usage disable when recording or executing a macro
		disable_in_macro = false,
	})

	require("nvim-treesitter.configs").setup({ autopairs = { enable = true } })
end

return M
