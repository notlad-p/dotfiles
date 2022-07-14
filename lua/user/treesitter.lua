local M = {}

M.config = function()
	local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")

	if not status_ok then
		print("Treesitter not ready")
		return
	end

	treesitter_configs.setup({
		ensure_installed = {
			"javascript",
			"typescript",
			"tsx",
			"json",
			"css",
			"java",
			"lua",
			"python",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		indent = { enable = true },
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
	})
end

return M
