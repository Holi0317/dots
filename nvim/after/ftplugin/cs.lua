vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

require("user.lsp").setup("omnisharp", {
	override = {
		handlers = {
			["textDocument/definition"] = require("omnisharp_extended").handler,
		},
	},
})
