local M = {}

function M.mason()
	require("mason").setup()
end

function M.lspconfig()
	require("mason-lspconfig").setup({
		ensure_installed = { "sumneko_lua" }
	})
end

function M.luadev()
	require("lua-dev").setup({
		-- add any options here, or leave empty to use the default settings
	})
end

return M
