local M = {}

function M.lspconfig()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = { "sumneko_lua" }
	})
end

return M
