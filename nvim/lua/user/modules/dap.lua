return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		config = function()
			vim.fn.sign_define("DapBreakpoint", {
				text = "󰃤",
				texthl = "DiagnosticError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "󰃤",
				texthl = "DiagnosticHint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "",
				texthl = "DiagnosticSignInfo",
				linehl = "DiagnosticUnderlineInfo",
				numhl = "DiagnosticSignInfo",
			})
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},
		lazy = true,
		-- FIXME: Find way to load this
		config = function()
			local dapui = require("dapui")
			local dap = require("dap")
			dapui.setup()

			local opened = false

			dap.listeners.after.event_initialized["dapui_config"] = function()
				if opened then
					return
				end

				dapui.open()
				opened = true
			end
		end,
	},

	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
		-- FIXME: Find way to load this
		lazy = true,
		config = {
			debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
		},
	},
}
