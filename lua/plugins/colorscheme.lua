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
    dir = "~/projects/lad-schemes.nvim",
    name = "lad-schemes",
    config = function()
      require("lad-schemes").setup {
        scheme = "gruvbox",
      }
    end,
  },

  -- tools for creating colorschemes
  "rktjmp/lush.nvim",
  "rktjmp/shipwright.nvim",
}
