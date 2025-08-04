return {
  {

    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- vim.diagnostic.config({ float = { border = "single " } })
      -- local border = {
      --   { "🭽", "FloatBorder" },
      --
      --   { "▔", "FloatBorder" },
      --   { "🭾", "FloatBorder" },
      --   { "▕", "FloatBorder" },
      --   { "🭿", "FloatBorder" },
      --   { "▁", "FloatBorder" },
      --   { "🭼", "FloatBorder" },
      --   { "▏", "FloatBorder" },
      -- }
      -- keys[#keys + 1] = {
      --   "K",
      --   function()
      --     return vim.lsp.buf.hover({ border = "single" })
      --   end,
      --   desc = "Hover",
      -- }
      local format = function(diagnostic)
        local diagnostic_str = diagnostic.message

        if diagnostic.source then
          diagnostic_str = diagnostic_str .. " (" .. diagnostic.source
        end

        if tostring(diagnostic.code) and not tostring(diagnostic.code) == "nil" then
          return diagnostic_str .. ": " .. tostring(diagnostic.code) .. ")"
        end

        return diagnostic_str .. ")"
      end

      local virtual_text_config = {
        spacing = 4,
        -- source = true,
        prefix = "●",
        format = format,
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      }

      local virtual_lines_config = {
        format = format,
      }

      ---@type vim.diagnostic.Opts
      local diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = virtual_text_config,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      }

      keys[#keys + 1] = {
        "gl",
        function()
          vim.diagnostic.open_float(0)
        end,
        desc = "Show line diagnostics",
      }

      -- toggle virtual lines diagnostics
      keys[#keys + 1] = {
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
      }

      -- remap 'c' keymaps to 'l'
      for key, value in pairs(keys) do
        local isCodeMap = string.find(value[1], "<leader>c")

        if isCodeMap then
          keys[key][1] = string.gsub(keys[key][1], "<leader>c", "<leader>l")
        end
      end

      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = diagnostics,
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },

        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
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
            root_dir = function(fname)
              local util = require("lspconfig/util")
              return util.root_pattern(
                "tailwind.config.js",
                "tailwind.config.cjs",
                "tailwind.js",
                "tailwind.cjs",
                "tailwind.config.ts"
              )(fname)
            end,
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

          -- ts_ls = {
          --   root_dir = function(fname)
          --     local util = require("lspconfig/util")
          --     return util.root_pattern("tsconfig.json", "package.json")(fname)
          --     -- and not util.root_pattern "deno.json"(fname)
          --   end,
          --   -- so that deno projects can't use ts_ls: https://www.reddit.com/r/neovim/comments/10n795v/disable_tsserver_in_deno_projects/
          --   -- NOTE: enable this if you intend to use ts_ls for single file javascript/typescript files
          --   single_file_support = false,
          -- },
        },

        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
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
    "williamboman/mason.nvim",
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
