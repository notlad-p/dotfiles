local M = {}

M.setup = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = require("user.alpha.header")

	dashboard.section.buttons.val = {
		dashboard.button("SPC f", "  Find File", "<CMD>Telescope find_files<CR>"),
		dashboard.button("SPC n", "  New File", "<CMD>ene!<CR>"),
		dashboard.button("SPC P", "  Recent Projects", "<CMD>Telescope projects<CR>"),
		dashboard.button("SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>"),
		dashboard.button("SPC s t", "  Find Word", "<CMD>Telescope live_grep<CR>"),
	}

	local function footer()
		-- Number of plugins
		local total_plugins = #vim.tbl_keys(packer_plugins)
		local plugins_text = "    "
			.. total_plugins
			.. " plugins"
			.. " |   v"
			.. vim.version().major
			.. "."
			.. vim.version().minor
			.. "."
			.. vim.version().patch

		return plugins_text
	end

	dashboard.section.footer.val = footer()

	-- hl (highlight) changes color
	-- based on highlight groups:
	-- https://neovim.io/doc/user/syntax.html#group-name
	dashboard.section.header.opts.hl = "Special"
	-- dashboard.section.buttons.opts.hl = "Include" - Not implemented yet?
	dashboard.section.footer.opts.hl = "Type"

	alpha.setup(dashboard.config)
end

return M
