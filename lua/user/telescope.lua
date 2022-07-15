local M = {}

local _, builtin = pcall(require, "telescope.builtin")

-- Smartly opens either git_files or find_files, depending on whether the working directory is
-- contained in a Git repo.
function M.find_project_files()
	local ok = pcall(builtin.git_files)

	if not ok then
		builtin.find_files()
	end
end

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
