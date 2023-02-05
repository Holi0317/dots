local plugin = require("user.pack").register_plugin

plugin({
	"akinsho/toggleterm.nvim",
	tag = "*",
	config = function()
		require("user.modules.term.config").toggleterm()
	end,
})

plugin({
	"samjwill/nvim-unception",
})
