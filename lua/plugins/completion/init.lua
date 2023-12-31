local jumpable = require "plugins.completion.jumpable"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  -- completions
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
    },
    opts = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      local config = {
        max_width = 0,
        kind_icons = {
          Class = " ",
          Color = " ",
          Constant = "ﲀ ",
          Constructor = " ",
          Enum = "練",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = "",
          Folder = " ",
          Function = " ",
          Interface = "ﰮ ",
          Keyword = " ",
          Method = " ",
          Module = " ",
          Operator = "",
          Property = " ",
          Reference = " ",
          Snippet = " ",
          Struct = " ",
          Text = " ",
          TypeParameter = " ",
          Unit = "塞",
          Value = " ",
          Variable = " ",
        },
        source_names = {
          nvim_lsp = "(LSP)",
          nvim_lua = "(NVIM)",
          path = "(Path)",
          luasnip = "(Snippet)",
          buffer = "(Buffer)",
        },
        duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        },
        duplicates_default = 0,
      }

      return {
        completion = {
          -- 'noselect' is important for not selecting the first
          -- completion option by default.
          completeopt = "menu,menuone,noinsert,noselect",
        },
        -- setup luasnip
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        -- Customize window appearance (Add boarder)
        window = {
          -- completion = cmp.config.window.bordered({
          --   winhighlight = "Pmenu",
          -- }),
          -- documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
          -- { name = "nvim_lua" },
          { name = "buffer" },
          -- { name = "calc" },
          -- { name = "emoji" },
          -- { name = "treesitter" },
          -- { name = "crates" },
          -- { name = "tmux" },
        },
        cmdline = {
          options = {
            {
              type = ":",
              sources = {
                { name = "path" },
                { name = "cmdline" },
              },
            },
            {
              type = { "/", "?" },
              sources = {
                { name = "buffer" },
              },
            },
          },
        },
        -- Keymappings
        mapping = cmp.mapping.preset.insert {
          -- completion menu movement with CTRL k,j
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),

          -- docs window scrolling
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          -- Ctrl y to complete
          ["<C-y>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          -- Ctrl e to abort
          ["<C-e>"] = cmp.mapping.abort(),
          -- Alt w to abort
          ["<M-w>"] = cmp.mapping.abort(),

          -- Tab, Shift Tab, and Enter mappings
          -- Stolen from LunarVim:
          -- https://github.com/LunarVim/LunarVim
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              -- cmp.complete()
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local confirm_opts = {}
              local is_insert_mode = function()
                return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
              end
              if is_insert_mode() then -- prevent overwriting brackets
                confirm_opts.behavior = cmp.ConfirmBehavior.Insert
              end
              if cmp.confirm(confirm_opts) then
                return -- success, exit early
              end
            end
            fallback() -- if not exited early, always fallback
          end),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local max_width = config.max_width
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
            end

            -- set menu icons
            vim_item.kind = config.kind_icons[vim_item.kind]

            -- set menu source names
            vim_item.menu = config.source_names[entry.source.name]

            -- Remove duplicates in cmp
            vim_item.dup = config.duplicates[entry.source.name] or config.duplicates_default

            return vim_item
          end,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require "cmp"

      for _, option in ipairs(opts.cmdline.options) do
        cmp.setup.cmdline(option.type, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = option.sources,
        })
      end

      cmp.setup(opts)
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = true,
        keymap = { open = "<M-p>" },
        layout = { position = "bottom", ratio = 0.3 },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = { accept_word = "<M-i>", accept_line = "<M-o>" },
      },
    },
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/nvim/snippets" } }
    end,
  },
}
