return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        trigger = {

          show_on_insert_on_trigger_character = true,
          -- show_on_blocked_trigger_characters = {},
        },
        menu = {
          border = "single",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_next()
            end
          end,
          "snippet_forward",
          "fallback",
        },

        ["<CR>"] = { "accept", "fallback" },
        ["<C-n>"] = { "show", "select_next", "fallback_to_mappings" },
        ["<C-space>"] = {
          function(cmp)
            cmp.show({ providers = { "lsp" } })
          end,
        },
      },

      sources = {
        providers = {
          snippets = {
            opts = {
              extended_filetypes = {
                dart = { "flutter" },
              },
            },
          },
        },
      },
    },
  },
}
