local M = {}

-- list registered providers (for lualine)
function M.list_registered_providers_names(filetype)
	local s = require("null-ls.sources")
	local available_sources = s.get_available(filetype)
	local registered = {}
	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end
	return registered
end

M.setup = function()
	local status_ok, null_ls = pcall(require, "null-ls")
	if not status_ok then
		print("Missing null-ls dependency")
		return
	end

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		on_attach = function(client, bufnr)
			-- setup formatting on save
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,

		-- list of current formmaters & linters
		sources = {
			-- formatters
			formatting.prettierd.with({
				-- to use with svelte install plugin globaly
				-- https://github.com/sveltejs/prettier-plugin-svelte
				extra_filetypes = { "svelte" },
			}),
			formatting.stylua,
			-- linters
			diagnostics.eslint_d,
			diagnostics.luacheck,
		},
	})
end

return M
