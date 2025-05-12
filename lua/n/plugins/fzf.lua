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

		vim.keymap.set("n", "<leader>pF", function()
			local oil_ok, oil = pcall(require, "oil")
			if not oil_ok then
				return
			end
			local current_dir = oil.get_current_dir()
			if current_dir then
				require("fzf-lua").files({ hidden = true, no_ignore = true, cwd = current_dir })
			end
		end, { desc = "Files in Folder" })

		vim.keymap.set("n", "<leader>pG", function()
			local oil_ok, oil = pcall(require, "oil")
			if not oil_ok then
				return
			end
			local current_dir = oil.get_current_dir()
			if current_dir then
				require("fzf-lua").live_grep_native({ hidden = true, no_ignore = true, cwd = current_dir })
			end
		end, { desc = "Grep in Folder" })
	end,
}
