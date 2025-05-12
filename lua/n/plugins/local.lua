local local_plugins = {
	{
		"drupal",
		dir = "~/proj/lua/drupal",
		config = function()
			local drupal = require("drupal")

			vim.keymap.set("n", "<leader>cr", function()
				drupal.drush_cr()
			end)
		end,
	},
}

return local_plugins
