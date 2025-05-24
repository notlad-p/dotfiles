local wezterm = require("wezterm")

local test
local onedark = {
	bg = "#1a212e",
	bg_3 = "#2a324a",
	bg_d = "#141b24",
	fg = "#93a4c3",
	black = "#0c0e15",
	ansi = {
		"#0c0e15",
		"#f65866",
		"#8bcd5b",
		"#efbd5d",
		"#41a7fc",
		"#c75ae8",
		"#34bfd0",
		"#93a4c3",
	},
	brights = {
		"#24262c",
		"#f87985",
		"#a2d77c",
		"#f2ca7d",
		"#67b9fd",
		"#d27bed",
		"#5dccd9",
		"#c9d2e1",
	},
	selection_fg = "#0c0e15",
	selection_bg = "#41a7fc",
}

local gruvbox = {
	bg = "#282828",
	bg_3 = "#3f3f3f",
	bg_d = "#232323",
	fg = "#ebdbb2",
	black = "#0c0e15",
	ansi = {
		"#0c0e15",
		"#fb4934",
		"#b8bb26",
		"#fabd2f",
		"#83a598",
		"#d3869b",
		"#8ec07c",
		"#ebdbb2",
	},
	brights = {
		"#24262c",
		"#fc6d5d",
		"#c6c951",
		"#fbca59",
		"#9cb7ad",
		"#dc9eaf",
		"#a5cd96",
		"#efe2c1",
	},
	selection_fg = "#b8bb26",
	selection_bg = "#4b4b4b",
}

local schemes = {
	onedark = onedark,
	gruvbox = gruvbox,
}

local color_scheme = "gruvbox"
local selected_scheme = schemes[color_scheme]
local colors = {}

for key, value in pairs(selected_scheme) do
	colors[key] = value
end

return {
	font = wezterm.font("Liga SFMono Nerd Font"),
	font_size = 13.5,
	underline_position = -3,
	underline_thickness = 1.5,
	line_height = 1.1,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	hide_tab_bar_if_only_one_tab = true,
	window_frame = {
		active_titlebar_bg = "#131822",
		inactive_titlebar_bg = "#131822",
	},
	colors = {
		foreground = colors.fg,
		background = colors.bg,
		cursor_bg = colors.fg,
		cursor_fg = colors.bg,
		cursor_border = colors.fg,
		selection_fg = colors.selection_fg,
		selection_bg = colors.selection_bg,
		ansi = colors.ansi,
		brights = colors.brights,
		tab_bar = {
			background = colors.bg,
			active_tab = {
				bg_color = colors.bg,
				fg_color = colors.fg,
			},
			inactive_tab = {
				bg_color = "#131822",
				fg_color = "#455574",
			},
			inactive_tab_hover = {
				bg_color = colors.bg_3,
				fg_color = "#c9d2e1",
			},
			new_tab = {
				bg_color = colors.bg,
				fg_color = colors.fg,
			},
			new_tab_hover = {
				bg_color = colors.bg_3,
				fg_color = "#c9d2e1",
			},
		},
	},
	keys = {
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "r",
			mods = "CMD|SHIFT",
			action = wezterm.action.ReloadConfiguration,
		},
	},
}
