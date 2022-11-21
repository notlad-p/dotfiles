local M = {}

M.setup = function()
	local which_key = require("which-key")

	-- which-key general config
	which_key.setup({
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		operators = { gc = "Comments" },
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
	})

	-- normal mode options
	local nopts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	-- normal mode mappings
	local nmappings = {
		-- [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
		["w"] = { "<cmd>w!<CR>", "Save" },
		["q"] = { "<cmd>lua require('user.utils.functions').smart_quit()<CR>", "Quit" },
		["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
		["c"] = { "<cmd>Bdelete<CR>", "Close Buffer" },
		["f"] = { require("user.telescope").find_project_files, "Find File" },
		["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		b = {
			name = "Buffers",
			j = { "<cmd>BufferLinePick<cr>", "Jump" },
			f = { "<cmd>Telescope buffers<cr>", "Find" },
			b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
			-- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
			e = {
				"<cmd>BufferLinePickClose<cr>",
				"Pick which buffer to close",
			},
			h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
			l = {
				"<cmd>BufferLineCloseRight<cr>",
				"Close all to the right",
			},
			D = {
				"<cmd>BufferLineSortByDirectory<cr>",
				"Sort by directory",
			},
			L = {
				"<cmd>BufferLineSortByExtension<cr>",
				"Sort by language",
			},
		},
		p = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},

		-- " Available Debug Adapters:
		-- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
		-- " Adapter configuration and installation instructions:
		-- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		-- " Debug Adapter protocol:
		-- "   https://microsoft.github.io/debug-adapter-protocol/
		-- " Debugging
		g = {
			name = "Git",
			j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
			C = {
				"<cmd>Telescope git_bcommits<cr>",
				"Checkout commit(for current file)",
			},
			d = {
				"<cmd>Gitsigns diffthis HEAD<cr>",
				"Git Diff",
			},
		},

		l = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
			w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
			f = { "<cmd>lua vim.lsp.buf.format({ buf = vim.api.nvim_get_current_buf() })<cr>", "Format" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			I = { "<cmd>LspInstallInfo<cr>", "Install Info" },
			j = {
				vim.diagnostic.goto_next,
				"Next Diagnostic",
			},
			k = {
				vim.diagnostic.goto_prev,
				"Prev Diagnostic",
			},
			l = { vim.lsp.codelens.run, "CodeLens Action" },
			t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definition" },
			c = { "<cmd>Telescope lsp_references<cr>", "Find References" },
			n = { vim.lsp.buf.definition, "Goto Definition" },
			q = { vim.diagnostic.setloclist, "Quickfix" },
			r = { vim.lsp.buf.rename, "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
			e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
		},
		s = {
			name = "Search",
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			t = { "<cmd>Telescope live_grep<cr>", "Text" },
			T = { "<cmd>TodoTelescope<cr>", "Todos" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
		},
		T = {
			name = "Treesitter",
			i = { ":TSConfigInfo<cr>", "Info" },
		},
		t = {
			name = "Terminal",
			l = { "5:TermExec cmd='lazygit'<CR>", "LazyGit" },
		},
	}

	-- register normal mode mappings
	which_key.register(nmappings, nopts)

	-- visual mode options
	local vopts = {
		mode = "v", -- VISUAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	-- visual mode mappings
	local vmappings = {
		["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment" },
	}

	-- register visual mode mappings
	which_key.register(vmappings, vopts)
end

return M
