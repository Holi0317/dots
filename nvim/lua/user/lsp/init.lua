local lspconfig = require("lspconfig")
local cmp_nvim = require("cmp_nvim_lsp")
local lspformat = require("lsp-format")
local callbacks = require("user.lsp.callbacks")

local M = {}

-- manually start the server and don't wait for the usual filetype trigger from lspconfig
local function buf_try_add(server)
	local bufnr = vim.api.nvim_get_current_buf()
	server.manager.try_add_wrapper(bufnr)
end

function M.common_capabilities()
	return cmp_nvim.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

---@class LspSetupConfig
---@field override? any Table of options to override
---@field enable_format? boolean Enable formatting from this lsp. Default to false.

---Setup the given server
---@param server_name string Name of the server listed in lspconfig
---@param custom? LspSetupConfig Additional overrides to be passed into setup function
function M.setup(server_name, custom)
	custom = custom or {}

	local capabilities = M.common_capabilities()

	local defaults = {
		on_attach = function(client, bufnr)
			if custom.enable_format then
				lspformat.on_attach(client)
			end

			callbacks.on_attach(client, bufnr)
		end,
		on_init = callbacks.on_init,
		on_exit = callbacks.on_exit,
		capabilities = capabilities,
	}

	local opt = vim.tbl_deep_extend("force", defaults, custom.override or {})

	local server = lspconfig[server_name]
	server.setup(opt)

	buf_try_add(server)
end

---Setup javascript/typescript/volar.
---Putting this as a special function for supporting volar takeover mode later
function M.setup_js()
	M.setup("tsserver")
end

return M
