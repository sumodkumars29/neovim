return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			--			require("dap").setup()
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()

			local bashdb_debugger = vim.fn.exepath("bashdb")
			if bashdb_debugger ~= "" then
				dap.adapters.bashdb = {
					type = "executable",
					command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
					name = "bashdb",
				}

				dap.configurations.sh = {
					{
						type = "bashdb",
						request = "launch",
						name = "Launch file",
						showDebugOutput = true,
						pathBashdb = vim.fn.stdpath("data")
							.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
						pathBashdbLib = vim.fn.stdpath("data")
							.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
						trace = true,
						file = "${file}",
						program = "${file}",
						cwd = "${workspaceFolder}",
						pathCat = "cat",
						pathBash = "/bin/bash",
						pathMkfifo = "mkfifo",
						pathPkill = "pkill",
						-- args = {},
						args = {},
						argsString = "",
						env = {},
						terminalKind = "integrated",
					},
					{
						type = "bashdb",
						request = "launch",
						name = "Launch with Arguments",
						showDebugOutput = true,
						pathBashdb = vim.fn.stdpath("data")
							.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
						pathBashdbLib = vim.fn.stdpath("data")
							.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
						trace = true,
						file = "${file}",
						program = "${file}",
						cwd = "${workspaceFolder}",
						pathCat = "cat",
						pathBash = "/bin/bash",
						pathMkfifo = "mkfifo",
						pathPkill = "pkill",
						-- args = {},
						args = function()
							local usb = vim.fn.input("Enter USB name: ")
							return { usb }
						end,
						argsString = "",
						env = {},
						terminalKind = "integrated",
					},
				}
			end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
			vim.keymap.set("n", "<Leader>dr", dap.restart, {})
			vim.keymap.set("n", "<F8>", dap.step_into, {})
			vim.keymap.set("n", "<F9>", dap.step_back, {})
			vim.keymap.set("n", "<F10>", dap.step_over, {})
			vim.keymap.set("n", "<F12>", dap.step_out, {})

			vim.keymap.set("n", "<Leader>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
