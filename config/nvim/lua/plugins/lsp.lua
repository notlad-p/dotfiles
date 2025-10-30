return {
  {

    "neovim/nvim-lspconfig",
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- Enable this to enable the builtin LSP folding on Neovim.
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the folds.
        folds = {
          enabled = true,
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        -- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
        ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
        ---@type table<string, lazyvim.lsp.Config|boolean>
        servers = {
          -- configuration for all lsp servers
          ["*"] = {
            capabilities = {
              workspace = {
                fileOperations = {
                  didRename = true,
                  willRename = true,
                },
              },
            },
            keys = {
              {
                "<leader>ll",
                function()
                  Snacks.picker.lsp_config()
                end,
                desc = "Lsp Info",
              },
              { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
              { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
              { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
              { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
              { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
              {
                "K",
                function()
                  return vim.lsp.buf.hover()
                end,
                desc = "Hover",
              },
              {
                "gK",
                function()
                  return vim.lsp.buf.signature_help()
                end,
                desc = "Signature Help",
                has = "signatureHelp",
              },
              {
                "<c-k>",
                function()
                  return vim.lsp.buf.signature_help()
                end,
                mode = "i",
                desc = "Signature Help",
                has = "signatureHelp",
              },
              { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" }, has = "codeAction" },
              { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
              {
                "<leader>lC",
                vim.lsp.codelens.refresh,
                desc = "Refresh & Display Codelens",
                mode = { "n" },
                has = "codeLens",
              },
              {
                "<leader>lR",
                function()
                  Snacks.rename.rename_file()
                end,
                desc = "Rename File",
                mode = { "n" },
                has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
              },
              { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
              { "<leader>lA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
              {
                "]]",
                function()
                  Snacks.words.jump(vim.v.count1)
                end,
                has = "documentHighlight",
                desc = "Next Reference",
                enabled = function()
                  return Snacks.words.is_enabled()
                end,
              },
              {
                "[[",
                function()
                  Snacks.words.jump(-vim.v.count1)
                end,
                has = "documentHighlight",
                desc = "Prev Reference",
                enabled = function()
                  return Snacks.words.is_enabled()
                end,
              },
              {
                "<a-n>",
                function()
                  Snacks.words.jump(vim.v.count1, true)
                end,
                has = "documentHighlight",
                desc = "Next Reference",
                enabled = function()
                  return Snacks.words.is_enabled()
                end,
              },
              {
                "<a-p>",
                function()
                  Snacks.words.jump(-vim.v.count1, true)
                end,
                has = "documentHighlight",
                desc = "Prev Reference",
                enabled = function()
                  return Snacks.words.is_enabled()
                end,
              },
              {
                "gl",
                function()
                  -- vim.diagnostic.open_float(0)
                  vim.diagnostic.open_float()
                end,
                desc = "Show line diagnostics",
              },
              {
                "<leader>uv",
                function()
                  local is_vt = not vim.diagnostic.config().virtual_text

                  if is_vt then
                    diagnostics.virtual_text = virtual_text_config
                    diagnostics.virtual_lines = false
                    vim.diagnostic.config(diagnostics)
                  else
                    vim.diagnostic.config({ virtual_lines = virtual_lines_config, virtual_text = false })
                  end

                  -- vim.api.nvim_create_autocmd("CursorMoved", {
                  --   group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
                  --   callback = function()
                  --     vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
                  --     return true
                  --   end,
                  -- })
                  -- return vim.lsp.buf.hover({ virtual_lines = {} })
                end,
                desc = "Toggle diagnostics virtual lines",
              },
            },
          },
          qmlls = {
            cmd = { "qmlls", "-E" },
          },

          denols = {
            single_file_support = false,
            root_dir = function(fname)
              local util = require("lspconfig/util")
              return util.root_pattern("deno.json")(fname)
              -- return false
            end,
          },

          jsonls = {
            -- lazy-load schemastore when needed
            on_new_config = function(new_config)
              new_config.settings.json.schemas = new_config.settings.json.schemas or {}
              vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
              json = {
                format = {
                  enable = true,
                },
                validate = { enable = true },
              },
            },
          },

          dartls = {
            enabled = true,
          },

          ruff = {
            keys = {
              {
                "<leader>lo",
                LazyVim.lsp.action["source.organizeImports"],
                desc = "Organize Imports",
              },
            },
          },

          tailwindcss = {
            -- enabled = false,
            enabled = true,
            settings = {
              tailwindCSS = {
                classAttributes = { "class", "className", "ngClass", "class:list", "cssClasses" },
                classFunctions = { "tw", "clsx" },
              },
            },
          },

          --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
          --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
          tsserver = {
            enabled = false,
          },
          ts_ls = {
            enabled = false,
          },
          vtsls = {
            -- explicitly add default filetypes, so that we can extend
            -- them in related extras
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
            },
            settings = {
              complete_function_calls = true,
              vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                  maxInlayHintLength = 30,
                  completion = {
                    enableServerSideFuzzyMatch = true,
                  },
                },
              },
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                  completeFunctionCalls = true,
                },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
            keys = {
              {
                "gD",
                function()
                  local params = vim.lsp.util.make_position_params()
                  LazyVim.lsp.execute({
                    command = "typescript.goToSourceDefinition",
                    arguments = { params.textDocument.uri, params.position },
                    open = true,
                  })
                end,
                desc = "Goto Source Definition",
              },
              {
                "gR",
                function()
                  LazyVim.lsp.execute({
                    command = "typescript.findAllFileReferences",
                    arguments = { vim.uri_from_bufnr(0) },
                    open = true,
                  })
                end,
                desc = "File References",
              },
              {
                "<leader>co",
                LazyVim.lsp.action["source.organizeImports"],
                desc = "Organize Imports",
              },
              {
                "<leader>cM",
                LazyVim.lsp.action["source.addMissingImports.ts"],
                desc = "Add missing imports",
              },
              {
                "<leader>cu",
                LazyVim.lsp.action["source.removeUnused.ts"],
                desc = "Remove unused imports",
              },
              {
                "<leader>cD",
                LazyVim.lsp.action["source.fixAll.ts"],
                desc = "Fix all diagnostics",
              },
              {
                "<leader>cV",
                function()
                  LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
                end,
                desc = "Select TS workspace version",
              },
            },
          },

          stylua = { enabled = false },
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        -- "typescript-language-server", -- ts_ls
        "vtsls",
        "css-lsp",
        "tailwindcss-language-server", -- tailwindcss
        "deno", -- denols
        "sqls",
        "bash-language-server", -- bashls
        "basedpyright",
        "ruff", -- (linter & formatter)
        "json-lsp",

        -- formatters
        "stylua",
        "shfmt",
        "prettierd",

        -- linters
        "luacheck",
        "eslint-lsp", -- technically an LSP
        "shellcheck",
      },
    },
    keys = { { "<leader>cm", false }, { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
}
