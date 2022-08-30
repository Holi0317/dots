local M = {
	mappings = {}
}

function M.setup()
	local wk = require("which-key")

	wk.register(M.mappings, {
		prefix = "<leader>",
	})
end

return M
