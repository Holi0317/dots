local M = {}

function M.project()
	require("project_nvim").setup({
		detection_methods = { "pattern" },
		patterns = { ".git", ".obsidian" },
		ignore_lsp = {
			"null-ls",
		},
	})
end

return M
