local M = {}

function M.project()
	require("project_nvim").setup({
		ignore_lsp = {
			"null-ls",
		},
	})
end

return M
