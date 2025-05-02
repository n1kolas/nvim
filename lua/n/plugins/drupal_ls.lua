return {
	"jdrupal-dev/drupal_ls",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = "neovim/nvim-lspconfig",
	-- Requires cargo to be installed locally.
	build = "cargo build --release",
	config = function()
		local lspconfig = require("lspconfig")

		require("lspconfig.configs").drupal_ls = {
			default_config = {
				cmd = {
					vim.fn.stdpath("data") .. "/lazy/drupal_ls/target/release/drupal_ls",
					"--file",
					"/tmp/drupal_ls-log.txt",
					"--level",
					"info",
				},
				filetypes = { "php", "yaml" },
				root_dir = lspconfig.util.root_pattern("composer.json"),
				settings = {},
			},
		}

		lspconfig["drupal_ls"].setup({})
	end,
}
