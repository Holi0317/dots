local plugin = require("user.pack").register_plugin

plugin({
	"L3MON4D3/LuaSnip",
	requires = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		require("user.modules.cmp.config").snip()
	end,
})

plugin({
	"danymat/neogen",
	after = "LuaSnip",
	config = function()
		require("user.modules.cmp.config").neogen()
	end,
})

plugin({
	"onsails/lspkind.nvim",
	config = function()
		require("user.modules.cmp.config").lspkind()
	end,
})

plugin({
	"hrsh7th/nvim-cmp",
	requires = {
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"David-Kunz/cmp-npm",
		"hrsh7th/cmp-path",
		"ray-x/cmp-treesitter",
		"rcarriga/cmp-dap",
	},
	after = {
		"LuaSnip",
		"lspkind.nvim",
	},
	config = function()
		require("user.modules.cmp.config").cmp()
	end,
})
