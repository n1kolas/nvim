local local_plugins = {
	{
		"drupal",
		dir = "~/.config/nvim/.local/drupal",
		config = function()
			local drupal = require("drupal")

			vim.keymap.set("n", "<leader>cr", function()
				drupal.drush_cr()
			end)
		end,
	},
}

return local_plugins
