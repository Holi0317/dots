local M = {}

local attached_listener = false

---Attach event listener to kill all future tsserver starts
local function attach_listener()
	if attached_listener then
		return
	end

	attached_listener = true

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			if client.name == "tsserver" then
				client.stop()
			end
		end,
	})
end

function M.kill_tsserver()
	-- Kill existing tsserver
	local clients = vim.lsp.get_active_clients()
	for _, client in ipairs(clients) do
		if client.name == "tsserver" then
			client.stop()
		end
	end

	-- Kill future tsserver
	attach_listener()
end

return M
