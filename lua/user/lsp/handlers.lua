local M = {}

function M.setup()
	local config = {
		-- Diagnostic virtual text (Text that apears at end of line when a diagnostic is detected)
		virtual_text = true,
		signs = {
			-- active = true,
			-- Diagnostic Icons
			active = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
			},
		},
		-- underline diagnostics
		underline = true,
		-- don't update diagnostics in insert mode
		update_in_insert = false,
		severity_sort = true,
		-- floating diagnostic windows
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	-- loop signs and asign them in vim
	-- for _, sign in pairs(config.signs) do
	-- 	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	-- end

	vim.diagnostic.config(config)

	local float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
	}

	-- hover style (Shift K keybind)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)

	-- signatureHelp style (gs keybind)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
end

-- lsp keybinds
local buffer_mappings = {
	normal_mode = {
		["K"] = { vim.lsp.buf.hover, "Show hover" },
		["gd"] = { vim.lsp.buf.definition, "Go to Definition" },
		["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
		["gr"] = { vim.lsp.buf.references, "Go to references" },
		["gI"] = { vim.lsp.buf.implementation, "Go to Implementation" },
		["gs"] = { vim.lsp.buf.signature_help, "Show signature help" },
		-- ["gp"] = {
		--   function()
		--     require("lvim.lsp.peek").Peek "definition"
		--   end,
		--   "Peek definition",
		-- },
		-- ["gl"] = {
		--   function()
		--     local config = lvim.lsp.diagnostics.float
		--     config.scope = "line"
		--     vim.diagnostic.open_float(0, config)
		--   end,
		--   "Show line diagnostics",
		-- },
	},
	insert_mode = {},
	visual_mode = {},
}

local function add_lsp_buffer_keybindings(bufnr)
	local mappings = {
		normal_mode = "n",
		insert_mode = "i",
		visual_mode = "v",
	}

	-- loops through modes & mappings and adds them
	for mode_name, mode_char in pairs(mappings) do
		for key, remap in pairs(buffer_mappings[mode_name]) do
			local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
			vim.keymap.set(mode_char, key, remap[1], opts)
		end
	end
end

-- Funciton run on lsp attach
M.on_attach = function(client, bufnr)
	add_lsp_buffer_keybindings(bufnr)
end

-- Add capabilities for cmp-lsp
-- https://github.com/hrsh7th/cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
