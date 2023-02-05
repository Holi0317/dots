local plugin = require("user.pack").register_plugin

plugin({
	"williamboman/mason.nvim",
	requires = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("user.modules.lang.config").mason()
	end,
})

plugin({
	"neovim/nvim-lspconfig",
	requires = {
		"williamboman/mason-lspconfig.nvim",
	},
	after = "mason.nvim",
	config = function()
		require("user.modules.lang.config").lspconfig()
	end,
})

plugin({
	"folke/lua-dev.nvim",
	after = "nvim-lspconfig",
	config = function()
		require("user.modules.lang.config").luadev()
	end,
})

plugin({
	"jose-elias-alvarez/null-ls.nvim",
	after = "nvim-lspconfig",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		require("user.modules.lang.config").null()
	end,
})
