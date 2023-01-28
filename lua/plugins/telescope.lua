return {
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
      },
      pickers = {
        -- File Pickers
        find_files = {
          theme = "dropdown",
        },
        git_files = {
          theme = "dropdown",
        },
        grep_string = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "dropdown",
          only_sort_text = true,
        },
        -- Vim Pickers
        buffers = {
          theme = "dropdown",
        },
        oldfiles = {
          theme = "dropdown",
        },
        commands = {
          theme = "dropdown",
        },
        help_tags = {
          theme = "dropdown",
        },
        man_pages = {
          theme = "dropdown",
        },
        highlights = {
          theme = "dropdown",
        },
        registers = {
          theme = "dropdown",
        },
        keymaps = {
          theme = "dropdown",
        },

        -- Git Pickers
        git_branches = {
          theme = "dropdown",
        },
        -- LSP Pickers
        lsp_document_symbols = {
          theme = "dropdown",
        },
      },
    },
  },

  -- session searcher
  {
    "rmagatti/session-lens",
    opts = { theme = "dropdown" },
  },
}
