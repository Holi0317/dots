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
	"folke/neodev.nvim",
	after = "nvim-lspconfig",
	config = function()
		require("user.modules.lang.config").neodev()
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

plugin({
	"lukas-reineke/lsp-format.nvim",
	config = function()
		require("user.modules.lang.config").format()
	end,
})

plugin({
	"j-hui/fidget.nvim",
	config = function()
		require("user.modules.lang.config").fidget()
	end,
})

plugin({
	"glepnir/lspsaga.nvim",
	branch = "main",
	config = function()
		require("user.modules.lang.config").saga()
	end,
})

plugin({
	"b0o/schemastore.nvim",
})

plugin({
	"Hoffs/omnisharp-extended-lsp.nvim",
	ft = { "csharp" },
})

plugin({
	"jamessan/vim-gnupg",
	config = function()
		require("user.modules.lang.config").gnupg()
	end,
})
