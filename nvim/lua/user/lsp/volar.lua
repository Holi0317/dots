local bus = require("user.bus")

local M = {}

local attached_listener = false

function M.kill_tsserver()
	-- Kill existing tsserver
	local clients = vim.lsp.get_active_clients()
	for _, client in ipairs(clients) do
		if client.name == "tsserver" then
			client.stop()
		end
	end

	-- Kill future tsserver
	if not attached_listener then
		attached_listener = true

		bus.on("lsp_on_attach", function(client)
			if client.name == "tsserver" then
				client.stop()
			end
		end)
	end
end

return M
