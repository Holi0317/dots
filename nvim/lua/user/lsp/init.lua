local lspconfig = require("lspconfig")
local callbacks = require("user.lsp.callbacks")

local M = {}

-- manually start the server and don't wait for the usual filetype trigger from lspconfig
local function buf_try_add(server)
  local bufnr = vim.api.nvim_get_current_buf()
	server.manager.try_add_wrapper(bufnr)
end


---Setup the given server
---@param server_name string Name of the server listed in lspconfig
---@param custom any Additional overrides to be passed into setup function
function M.setup(server_name, custom)
	local defaults = {
		on_attach = callbacks.on_attach,
	}

	local opt = vim.tbl_deep_extend("force", defaults, custom or {})

	local server = lspconfig[server_name]
	server.setup(opt)

	buf_try_add(server)
end

return M
