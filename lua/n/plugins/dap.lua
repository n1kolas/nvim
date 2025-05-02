return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "»" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							"scopes",
							-- 'breakpoints',
							"stacks",
							-- 'watches',
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							--    'console',
						},
						size = 10,
						position = "bottom",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "rounded", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				controls = {
					-- Requires Neovim nightly (or 0.8 when released)
					enabled = false, -- because the icons don't work
					-- Display controls in this element
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				windows = { indent = 1 },
			})
			require("dap-go").setup()

			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = { "/path/to/phpDebug.js" },
			}
			dap.configurations.php = {
				{
					type = "php",
					name = "PHP: Docker",
					request = "launch",
					port = 9003,
					pathMappings = {
						["/var/www/html"] = "${workspaceFolder}",
					},
					xdebugSettings = {
						max_children = 100,
					},
				},
			}

			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F3>", dap.step_into)
			vim.keymap.set("n", "<F2>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F13>", dap.restart)

			vim.keymap.set("n", "<leader>du", function()
				require("dapui").toggle()
			end, { desc = "Toggle Debugger UI" })
			vim.keymap.set("n", "<leader>dw", function()
				dap = require("dap")
				dap.terminate()
				dap.close()
				ui.close()
			end, { desc = "Terminate" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
