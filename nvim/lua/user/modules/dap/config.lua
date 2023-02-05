local M = {}

function M.dap()
	local dap = require("dap")
	dap.adapters.node2 = {
		type = "executable",
		command = "node-debug2-adapter",
		args = {},
	}
end

function M.dapui()
	local dapui = require("dapui")
	local dap = require("dap")
	dapui.setup()

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

function M.js()
	require("dap-vscode-js").setup({
		debugger_path = vim.fn.stdpath("data") .. "/mason/packages/vscode-js-debug",
		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	})
end

return M
