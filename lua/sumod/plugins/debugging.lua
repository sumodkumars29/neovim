return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		event = "VeryLazy",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- require("dap").setup()
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()

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

			-- local bash_adapter = require("sumod.plugins.debug_adapters.bash")
			-- if bash_adapter and bash_adapter.setup then
			-- 	bash_adapter.setup()
			-- end

			local function load_adapter(name)
				local ok, adapter = pcall(require, "sumod.plugins.debug_adapters." .. name)
				if ok and adapter and adapter.setup then
					adapter.setup()
				end
			end

			load_adapter("bash")
		end,
	},
}
