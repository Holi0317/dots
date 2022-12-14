vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

require("user.lsp").setup("omnisharp", {
	enable_format = true,
	override = {
		handlers = {
			["textDocument/definition"] = require("omnisharp_extended").handler,
		},
		on_attach = function(client, bufnr)
			-- Enable formatting
			require("lsp-format").on_attach(client)

			require("user.lsp.callbacks").on_attach(client, bufnr)

			-- Override `gd` to **not** use trouble. Otherwise it breaks omnisharp_extended
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, {
				desc = "Goto Definition",
				buffer = bufnr,
			})
		end,
	},
})
