local M = {}

M.config = function()
	local components = require("user.lualine.components")

	require("lualine").setup({
		options = {
			theme = "auto",
			-- icons_enabled = lvim.use_icons,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "alpha", "NvimTree", "Outline" },
		},
		sections = {
			lualine_a = {
				components.mode,
			},
			lualine_b = {
				components.branch,
				components.filename,
			},
			lualine_c = {
				components.diff,
			},
			lualine_x = {
				components.diagnostics,
				components.treesitter,
				components.lsp,
				components.filetype,
			},
			lualine_y = {},
			lualine_z = {
				components.scrollbar,
			},
		},
		extensions = { "nvim-tree" },
	})
end

return M
