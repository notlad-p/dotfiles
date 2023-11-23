return {
  -- onedark theme
  -- use({
  -- 	"navarasu/onedark.nvim",
  -- 	as = "onedark",
  -- 	config = function()
  -- 		local onedark = require("onedark")
  --
  -- 		onedark.setup({
  -- 			style = "deep",
  -- 			-- transparent = true,
  -- 		})
  --
  -- 		onedark.load()
  -- 	end,
  -- })

  -- use { "Everblush/everblush.nvim", as = "everblush" }

  {
    lazy = false,
    priority = 1000,
    dir = "~/projects/lad-schemes.nvim",
    name = "lad-schemes",
    opts = {
      scheme = "gruvbox",
    },
  },

  -- tools for creating colorschemes
  "rktjmp/lush.nvim",
  "rktjmp/shipwright.nvim",
}
