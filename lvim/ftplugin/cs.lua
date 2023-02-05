vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

require("lvim.lsp.manager").setup("omnisharp", {
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
	},
})
