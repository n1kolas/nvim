return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		local dmode_enabled = false
		vim.api.nvim_create_autocmd("User", {
			pattern = "DebugModeChanged",
			callback = function(args)
				dmode_enabled = args.data.enabled
			end,
		})
		require("lualine").setup({
			options = {
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return dmode_enabled and "DEBUG" or str
						end,
						color = function(tb)
							return dmode_enabled and "dCursor" or tb
						end,
					},
				},
				lualine_b = {},
				lualine_c = {
					{ "filename", path = 1 },
					{ "branch" },
					{ "diff" },
					{ "diagnostics" },
					-- { macro },
				},
				lualine_x = {
					-- { lsp_status },
					{ "filetype" },
				},
				lualine_y = { { "progress" }, { "location" } },
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
