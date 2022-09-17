require("user.lsp").setup("sumneko_lua", {
	override = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
})
