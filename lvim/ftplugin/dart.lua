-- Load flutter snippets
require("luasnip").filetype_extend("dart", { "flutter" })

-- Need to wait for packer to load flutter plugin first
vim.defer_fn(function()
	local telescope = require("telescope")

	telescope.load_extension("flutter")
end, 10)

vim.api.nvim_buf_set_keymap(0, "n", "\\", "<cmd>Telescope flutter commands<cr>", { silent = true })

-- Fix comment string
vim.bo.commentstring = "//%s"
