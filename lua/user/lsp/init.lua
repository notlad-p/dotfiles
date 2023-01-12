local M = {}

M.setup = function()
  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    print "lspconfig not ready"
    return
  end

  -- setup mason & mason-lspconfig
  require("mason").setup {
    ui = {
      border = "rounded",
      icons = {
        server_installed = "✓",
        server_pending = "",
        server_uninstalled = "✗",
      },
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = {},
  }

  -- set lspconfig defaults
  -- See :help lspconfig-global-defaults
  local lsp_defaults = lspconfig.util.default_config
  lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

  -- setup servers automatically
  local default_handler = function(server_name)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
    }

    -- i prefer this method of setting up specific servers, it seems easier
    -- even though it's only a few less lines of code
    if server_name == "jsonls" then
      local jsonls_opts = require "user.lsp.providers.jsonls"
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server_name == "tailwindcss" then
      local tailwindcss_opts = require "user.lsp.providers.tailwindcss"
      opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
    end

    lspconfig[server_name].setup(opts)
  end

  -- setup handlers (signs, hover style)
  require("user.lsp.handlers").setup()

  require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    default_handler,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
  }

  -- setup null-ls for formatters and linters
  require("user.lsp.null-ls").setup()
end

return M
