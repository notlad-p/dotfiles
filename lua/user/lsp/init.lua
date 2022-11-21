local M = {}

M.setup = function()
	local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
	if not lspconfig_status_ok then
		print("lspconfig not ready")
		return
	end

	local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

	if not lsp_installer_ok then
		print("nvim-lsp-installer not ready")
		return
	end

	require("user.lsp.handlers").setup()

	-- setup nvim-lsp-installer
	lsp_installer.setup({
		-- ADD COMMON LSPs wanted HERE
		ensure_installed = {},
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "",
				server_uninstalled = "✗",
			},
		},
	})

	-- This starts the servers
	-- Loop through all of the installed servers and set it up via lspconfig
	for _, server in ipairs(lsp_installer.get_installed_servers()) do
		-- Add common on_attach and capabilities variable here
		local opts = {
			on_attach = require("user.lsp.handlers").on_attach,
			capabilities = require("user.lsp.handlers").capabilities,
		}

		-- Add options for specific servers here
		-- if server.name == "sumneko_lua" then
		--   local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		--   opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		-- end

		lspconfig[server.name].setup(opts)
	end

	-- setup null-ls for formatters and linters
	require("user.lsp.null-ls").setup()
end

return M
