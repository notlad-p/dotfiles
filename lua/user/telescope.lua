local M = {}

M.setup = function()
	require("telescope").setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			entry_prefix = "  ",
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})

	-- projects.nvim for project search
	require("telescope").load_extension("projects")

	require("telescope").load_extension("fzf")
end

return M
