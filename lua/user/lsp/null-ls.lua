local M = {}

M.setup = function()
	local status_ok, null_ls = pcall(require, "null-ls")
	if not status_ok then
		print("Missing null-ls dependency")
		return
	end

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	null_ls.setup({
		-- list of current formmaters & linters
		sources = {
			-- formatters
			formatting.prettierd,
			formatting.stylua,
			-- linters
			diagnostics.eslint_d,
			diagnostics.luacheck,
		},
	})
end

return M
