require("user.lsp").setup("lua_ls", {
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
