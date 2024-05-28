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
	"nvimtools/none-ls.nvim",
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
	branch = "legacy",
	config = function()
		require("user.modules.lang.config").fidget()
	end,
})

plugin({
	"nvimdev/lspsaga.nvim",
	branch = "main",
	config = function()
		require("user.modules.lang.config").saga()
	end,
})

plugin({
	"stevearc/aerial.nvim",
	config = function()
		require("user.modules.lang.config").aerial()
	end,
})

plugin({
	"b0o/schemastore.nvim",
})

plugin({
	"jamessan/vim-gnupg",
	config = function()
		require("user.modules.lang.config").gnupg()
	end,
})

-- Required by ts (and ts-like) languages. Used in `setup_tsserver`.
plugin({
	"pmizio/typescript-tools.nvim",
	requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
})
