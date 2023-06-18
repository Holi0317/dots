local plugin = require("user.pack").register_plugin

plugin({
	"nvim-lualine/lualine.nvim",
	requires = {
		"kyazdani42/nvim-web-devicons",
		opt = true,
	},
	config = function()
		require("user.modules.lines.config").lualine()
	end,
})

plugin({
	"akinsho/bufferline.nvim",
	tag = "*",
	after = { "gruvbox.nvim" },
	requires = {
		"kyazdani42/nvim-web-devicons",
		opt = true,
	},
	config = function()
		require("user.modules.lines.config").bufferline()
	end,
})

plugin({
	"ojroques/nvim-bufdel",
})
