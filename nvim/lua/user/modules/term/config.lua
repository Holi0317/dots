local M = {}

function M.toggleterm()
	require("toggleterm").setup({
		open_mapping = [[<c-\>]],
	})
end

return M
