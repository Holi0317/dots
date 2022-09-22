local plugin = require("user.pack").register_plugin

plugin({
	"mfussenegger/nvim-dap",
	config = function()
		require("user.modules.dap.config").dap()
	end,
})

plugin({
	"rcarriga/nvim-dap-ui",
	after = "nvim-dap",
	config = function()
		require("user.modules.dap.config").dapui()
	end,
})

plugin({
	"mxsdev/nvim-dap-vscode-js",
	requires = "nvim-dap",
	config = function()
		require("user.modules.dap.config").js()
	end,
})
