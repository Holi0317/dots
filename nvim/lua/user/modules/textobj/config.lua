local M = {}

function M.autopairs()
	require("nvim-autopairs").setup({})
end

function M.substitute()
	require("substitute").setup({})

	vim.keymap.set("n", "gs", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
	vim.keymap.set("n", "gss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
	vim.keymap.set("n", "gS", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
	vim.keymap.set("x", "gs", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
end

return M
