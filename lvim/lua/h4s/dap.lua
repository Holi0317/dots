local M = {}

M.setup = function()
	-- Make sure dap is active
	lvim.builtin.dap.active = true
	require("dap.ext.vscode").load_launchjs()

	-- DAP UI
	table.insert(lvim.plugins, {
		"rcarriga/nvim-dap-ui",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

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
		end,
	})

	local dap = require("dap")

	-- ==== Go ====
	table.insert(lvim.plugins, {
		"leoluz/nvim-dap-go",
		opt = true,
		ft = { "go" },
		config = function()
			require("dap-go").setup()
		end,
	})

	-- ==== Javascript ====
	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/dap/vscode-node-debug2/out/src/nodeDebug.js" },
	}

	dap.configurations.javascript = {
		{
			name = "Launch",
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			name = "Attach to process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
	}
end

return M
