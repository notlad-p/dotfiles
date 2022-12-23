local wezterm = require("wezterm")

-- TODO: Add custom keybinds (Close pane, adjust size of pane & new pane)
-- TODO: Change awesomeWM terminal keybind to wezterm

local colors = {
	bg = "#1a212e",
	bg_3 = "#2a324a",
	bg_d = "#141b24",
	fg = "#93a4c3",
	black = "#0c0e15",
}

return {
	color_scheme = "Batman",
	font = wezterm.font("Liga SFMono Nerd Font"),
	font_size = 13.5,
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
		selection_fg = "#0c0e15",
		selection_bg = "#41a7fc",
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
	},
}
