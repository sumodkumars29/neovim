local M = {}

M.setup = function()
	local dap = require("dap")

	-- Path to the debug adapter entry point
	local js_debug_dir = vim.fn.stdpath("data") .. "mason/packages/js-debug-adapter/js-debug/src"
	local js_debug_path = vim.fn.stdpath("data") .. "mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

	-- Check if the js-debug/src directory exists
	if vim.fn.isdirectory(js_debug_dir) ~= 1 then
		vim.notify("'src' directory not found at: " .. js_debug_dir, vim.log.levels.WARN)
		return
	end

	-- If the 'src' directory exists, verify that the dapDebugServer.js file is readable/not corrupted
	if vim.fn.filereadable(js_debug_path) == 0 then
		vim.notify("dapDebugServer.js not found. Run :MasonInstall js-debug-adapter", vim.log.levels.WARN)
		return
	end

	-- Set up adapter
	dap.adapters["pwa-node"] = {
		type = "server",
		host = "127.0.0.1",
		port = "${port}",
		executable = {
			command = "node",
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

		--- Start here to continue
	}
end
