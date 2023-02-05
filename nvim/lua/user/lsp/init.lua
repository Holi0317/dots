local lspconfig = require("lspconfig")
local cmp_nvim = require("cmp_nvim_lsp")
local lspformat = require("lsp-format")
local callbacks = require("user.lsp.callbacks")

local M = {
	---Set of configured language server names.
	---If a server already exist here, it will not be configured again.
	---@type table<string, boolean>
	configured = {},
}

-- manually start the server and don't wait for the usual filetype trigger from lspconfig
local function buf_try_add(server)
	local bufnr = vim.api.nvim_get_current_buf()
	server.manager.try_add_wrapper(bufnr)
end

function M.common_capabilities()
	return cmp_nvim.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

---@class LspSetupConfig
---@field override? any Table of options to override
---@field enable_format? boolean Enable formatting from this lsp. Default to false.

---Setup the given server
---@param server_name string Name of the server listed in lspconfig
---@param custom? LspSetupConfig Additional overrides to be passed into setup function
function M.setup(server_name, custom)
	if M.configured[server_name] then
		return
	end

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
	M.configured[server_name] = true
end

---Setup volar with takeover mode
---After calling this function, all existing tsserver will be killed and
---replaced with volar.
---
---Call this function in vue ftplugin. Optionally also call this in project
---`.vimrc.lua` to ensure volar is started even the first file to edit is not
---a vue file.
function M.setup_volar()
	local volar = require("user.lsp.volar")

	-- Skip future tsserver setup
	M.configured["tsserver"] = true

	volar.kill_tsserver()

	-- Start volar in takeover mode
	M.setup("volar", {
		override = {
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
		},
	})
end

return M
