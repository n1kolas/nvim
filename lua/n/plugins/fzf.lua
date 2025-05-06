return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		-- Search Files
		vim.keymap.set("n", "<C-p>", function()
			require("fzf-lua").files({ hidden = true, no_ignore = true })
		end, { desc = "Files" })
		vim.keymap.set("n", "<leader>pf", function()
			require("fzf-lua").files({ hidden = true, no_ignore = true })
		end, { desc = "Files" })

		-- Search Contents
		vim.keymap.set("n", "<leader>pg", function()
			require("fzf-lua").live_grep_native({ hidden = true, no_ignore = true })
		end, { desc = "Grep" })
	end,
}
