local M = {}

local conditions = {
	-- don't show if window width is less than 70
	hide_in_width = function()
		return vim.fn.winwidth(0) > 70
	end,
}

-- colors for status line
local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	purple = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}
local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

-- components to show in status line
local components = {
	-- mode indicator on left side of status line
	mode = {
		function()
			return " "
		end,
		padding = { left = 0, right = 0 },
		color = {},
		cond = nil,
	},
	-- current git branch
	branch = {
		"b:gitsigns_head",
		icon = " ",
		color = { gui = "bold" },
		cond = conditions.hide_in_width,
	},
	filename = {
		"filename",
		color = {},
		cond = nil,
	},
	diff = {
		"diff",
		source = diff_source,
		symbols = { added = "  ", modified = " ", removed = " " },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.yellow },
			removed = { fg = colors.red },
		},
		cond = nil,
	},
}

M.config = function()
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
		},
		extensions = { "nvim-tree" },
	})
end

return M
