local M = {}

M.setup = function()
	require("Comment").setup({
		pre_hook = function(_ctx)
			return require("ts_context_commentstring.internal").calculate_commentstring()
		end,
	})
end

return M
