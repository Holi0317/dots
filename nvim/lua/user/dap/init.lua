local dap = require("dap")

local M = {}

---Add an npm script to dap config
---
---@param script string Name of the script to add
---@param args string[]? Additional arguments for the npm script
---@param opts any
function M.npm(script, args, opts)
	local base_conf = {
		type = "pwa-node",
		request = "launch",
		name = "Npm: " .. script,
		runtimeExecutable = "npm",
		runtimeArgs = vim.list_extend({ "run", script }, args or {}),
		rootPath = "${workspaceFolder}",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		internalConsoleOptions = "neverOpen",
	}

	local conf = vim.tbl_extend("force", base_conf, opts or {})

	for _, ft in ipairs({ "javascript", "typescript", "vue" }) do
		if dap.configurations[ft] == nil then
			dap.configurations[ft] = {}
		end

		table.insert(dap.configurations[ft], conf)
	end
end

return M
