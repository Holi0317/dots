local plugin = require("user.pack").register_plugin

plugin({
	"phaazon/mind.nvim",
	branch = "v2",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		require("user.modules.mind.config").mind()
	end,
})
