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

	-- Enable treesitter
	require("nvim-treesitter.configs").setup({ autopairs = { enable = true } })

	-- For cmp autopairs after confirm
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return M
