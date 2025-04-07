local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
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
	server.manager:try_add_wrapper(bufnr)
end

function M.common_capabilities()
	return blink.get_lsp_capabilities()
end

---@class LspSetupConfig
---@field override? any Table of options to override
---@field enable_format? boolean Enable formatting from this lsp. Default to false.
---@field semantic_token? boolean Enable semantic token higlighting for this lsp. Default to true

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

			if custom.semantic_token == false then
				client.server_capabilities.semanticTokensProvider = nil
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

---Setup typescript server with vue/volar integration
---
---Instead of calling M.setup("ts_ls") in ftplugin, call this instead for all
---js-related languages, even if they are not using vue at all.
---
---This helper exists when volar support was a mess. Keeping this function
---around because ts_ls setup is still a bit special and a lot of languages are
---using it.
function M.setup_tsls()
	-- Ref: https://github.com/vuejs/language-tools/issues/3925
	local mason_registry = require("mason-registry")
	local vls_path = mason_registry.get_package("vue-language-server"):get_install_path()
	local ts_plugin_path = vls_path .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

	M.setup("ts_ls", {
		override = {
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = ts_plugin_path,
						languages = { "javascript", "typescript", "vue" },
					},
				},
			},
		},
	})
end

return M
