local plugin = require("user.pack").register_plugin

plugin({
	"neovim/nvim-lspconfig",
	requires = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config =function()
		require("user.modules.lang.config").lspconfig()
	end
})
