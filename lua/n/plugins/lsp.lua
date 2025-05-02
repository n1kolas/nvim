local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
    "ray-x/lsp_signature.nvim",
    "nvim-treesitter/nvim-treesitter",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {},
		})
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- Jumps to the declaration of the symbol under the cursor.
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

          -- Jumps to the definition of the symbol under the cursor.
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

          -- Displays hover information about the symbol under the cursor in a floating
          -- window. Calling the function twice will jump into the floating window.
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- Lists all the implementations for the symbol under the cursor in the quickfix window.
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

          -- Displays signature information about the symbol under the cursor in a floating window.
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

          -- Jumps to the definition of the type of the symbol under the cursor.
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)

          -- Renames all references to the symbol under the cursor.
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

          -- Selects a code action available at the current cursor position.
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

          -- Lists all the references to the symbol under the cursor in the quickfix window.
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    require("lsp_signature").setup({})

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"intelephense",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				intelephense = function()
					local lspconfig = require("lspconfig")
					lspconfig.intelephense.setup({
						config = {
							["intelephense.files.associations"] = {
								"*.inc",
								"*.theme",
								"*.install",
								"*.module",
								"*.profile",
								"*.php",
							},
						},
					})
				end,

				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								format = {
									enable = true,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}

