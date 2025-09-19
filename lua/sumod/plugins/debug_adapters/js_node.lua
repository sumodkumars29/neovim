local M = {}

M.setup = function()
	local dap = require("dap")

	-- Path to the debug adapter entry point
	-- local js_debug_dir = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src"
	local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
	-- local js_debug_path = vim.fn.expand("~/.local/share/nvim/mason/packages/js-debug-adapter")
	-- vim.fn.expand("~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js")

	local node_path = "/home/sumodk/.nvm/versions/node/v24.7.0/bin/node"

	-- Check if the js-debug/src directory exists
	-- if vim.fn.isdirectory(js_debug_dir) ~= 1 then
	-- 	vim.notify("'src' directory not found at: " .. js_debug_dir, vim.log.levels.WARN)
	-- 	return
	-- end

	-- If the 'src' directory exists, verify that the dapDebugServer.js file is readable/not corrupted
	if vim.fn.filereadable(js_debug_path) == 0 then
		vim.notify("dapDebugServer.js not found. Run :MasonInstall js-debug-adapter", vim.log.levels.WARN)
		return
	end

	-- Set up adapter
	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "/home/sumodk/.nvm/versions/node/v24.7.0/bin/node",
			args = { js_debug_path, "${port}" },
		},
	}

	-- Common environment for GTK & GDK apps
	local gtk_gdk_env = {
		GI_TYPELIB_PATH = "/usr/lib/girepository-1.0:/usr/lib64/girepository-1.0",
		LD_LIBRARY_PATH = "/usr/lib:/usr/lib64",
		GIO_MODULE_DIR = "/usr/lib/gio/modules",
	}

	-- Below is the configuration for launching node.js, attaching to a running node process ...
	-- launching node-gtk/gdk, attaching to a running node-gtk/gdk process ...
	-- and finally attaching to a running node-gtk/gdk process using "Port" ...
	-- in that order.

	dap.configurations.javascript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch JavaScript File",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**" },
		},

		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Node Process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},

		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Node-GTK/GDK App",
			program = "${file}",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "/home/sumodk/.nvm/versions/node/v24.7.0/bin/node",
			env = gtk_gdk_env,
			sourceMaps = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**" },
		},

		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Node-GTK/GDK Process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			env = gtk_gdk_env,
		},

		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Port (Node-GTK/GDK)",
			port = 9229,
			address = "localhost",
			localRoot = "${workspaceFolder}",
			remoteRoot = "${workspaceFolder}",
			env = gtk_gdk_env,
			restart = true,
		},
	}

	-- Extend to TypeScript files
	dap.configurations.typescript = dap.configurations.javascript
	dap.configurations.typescriptreact = dap.configurations.javascript
	dap.configurations.javascriptreact = dap.configurations.javascript

	vim.notify("JavaScript debugging configured with Node-GTK support", vim.log.levels.INFO)
end

return M
