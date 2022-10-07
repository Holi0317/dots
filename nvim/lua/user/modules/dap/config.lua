local M = {}

function M.dap()
	vim.fn.sign_define("DapBreakpoint", {
		text = "",
		texthl = "DiagnosticError",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapBreakpointRejected", {
		text = "",
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
end

function M.dapui()
	local dapui = require("dapui")
	local dap = require("dap")
	dapui.setup()

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
end

function M.js()
	require("dap-vscode-js").setup({
		debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	})
end

return M
