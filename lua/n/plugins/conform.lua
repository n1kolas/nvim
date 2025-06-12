return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				php = { "phpcbf" },
				rust = { "rustfmt" },
				go = { "goimports", "gofmt" },
				yaml = { "yamlfmt" },
				scss = { "prettierd" },
			},
			formatters = {
				phpcbf = function(bufnr)
					return {
						command = require("conform.util").find_executable({ "vendor/bin/phpcbf" }, "phpcbf"),
						args = function(_, ctx)
							return {
								"--standard=Drupal",
								"--extensions=php,module,inc,install,test,profile,theme,info",
								"$FILENAME",
							}
						end,
						stdin = false,
						tmpfile_format = "conform.$RANDOM.$FILENAME",
						exit_codes = { 0, 1, 2 },
					}
				end,
			},
		})
	end,
}
