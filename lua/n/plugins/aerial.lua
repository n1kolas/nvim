return {
	"stevearc/aerial.nvim",
	opts = {},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			autojump = false,
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				vim.keymap.set("n", "<leader>ap", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "<leader>an", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		})
		vim.keymap.set("n", "<leader>aa", "<cmd>AerialToggle!<CR>")
	end,
}
