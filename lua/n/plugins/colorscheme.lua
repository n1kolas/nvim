-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		require("catppuccin").setup({
-- 			color_overrides = {
-- 				mocha = {
-- 					base = "#080808",
-- 					mantle = "#080808",
-- 					crust = "#080808",
-- 				},
-- 			},
-- 			flavour = "mocha",
-- 		})
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }
-- function ColorMyPencils(color)
-- 	color = color or "rose-pine-moon"
-- 	vim.cmd.colorscheme(color)
--
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
--
-- return {
--     {
--         "rose-pine/neovim",
--         name = "rose-pine",
--         config = function()
--             require('rose-pine').setup({
--                 disable_background = true,
--                 styles = {
--                     italic = false,
--                 },
--             })
--
--             ColorMyPencils();
--         end
--     },
--
--
-- }

return {
	"tjdevries/colorbuddy.nvim",
	config = function()
		vim.cmd.colorscheme("gruvbuddy")
	end,
}
