local dap = require("dap")

local M = {}

local function setup_keybind()
	-- Need to wait dap.setup() completed
	lvim.builtin.dap.on_config_done = function()
		lvim.builtin.which_key.mappings["d"] = {
			name = "Debug",
			t = { dap.toggle_breakpoint, "Toggle Breakpoint" },
			b = { dap.step_back, "Step Back" },
			c = { dap.continue, "Continue" },
			C = { dap.run_to_cursor, "Run To Cursor" },
			d = { dap.disconnect, "Disconnect" },
			g = { dap.session, "Get Session" },
			i = { dap.step_into, "Step Into" },
			o = { dap.step_over, "Step Over" },
			n = { dap.step_over, "Next line (Step Over)" },
			u = { dap.step_out, "Step Out" },
			p = { dap.pause, "Pause" },
			r = { dap.toggle, "Toggle Repl" },
			s = { dap.continue, "Start" },
			q = { dap.close, "Quit" },
		}
	end
end

local function setup_go()
	dap.adapters.go = function(callback, config)
		local stdout = vim.loop.new_pipe(false)
		local handle
		local pid_or_err
		local port = 38697
		local opts = {
			stdio = { nil, stdout },
			args = { "dap", "--log", "-l", "127.0.0.1:" .. port },
			detached = true,
		}
		handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
			stdout:close()
			handle:close()
			if code ~= 0 then
				print("dlv exited with code", code)
			end
		end)
		assert(handle, "Error running dlv: " .. tostring(pid_or_err))
		stdout:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				vim.schedule(function()
					require("dap.repl").append(chunk)
				end)
			end
		end)
		-- Wait for delve to start
		vim.defer_fn(function()
			callback({ type = "server", host = "127.0.0.1", port = port })
		end, 100)
	end

	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${file}",
		},
		{
			type = "go",
			name = "Run main.go",
			request = "launch",
			program = "${workspaceFolder}/main.go",
		},
		{
			type = "go",
			name = "Debug test", -- configuration for debugging test files
			request = "launch",
			mode = "test",
			program = "${file}",
		},
		-- works with go.mod packages and sub packages
		{
			type = "go",
			name = "Debug test (go.mod)",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
		},
	}
end

local function setup_nodejs()
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

M.setup = function()
	-- Make sure dap is active
	lvim.builtin.dap.active = true

	-- Defer load launch.json to ensure cwd is correct
	vim.defer_fn(function()
		require("dap.ext.vscode").load_launchjs()
	end, 100)

	-- DAP UI
	table.insert(lvim.plugins, {
		"rcarriga/nvim-dap-ui",
		config = function()
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
		end,
	})

	setup_keybind()

	setup_go()
	setup_nodejs()
end

return M
