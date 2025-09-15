local M = {}

M.setup = function()
	local dap = require("dap")

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
				pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
				pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
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
				pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
				pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
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
end

return M
