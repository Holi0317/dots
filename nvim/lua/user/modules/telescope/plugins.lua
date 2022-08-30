local plugin = require("user.pack").register_plugin

plugin({
	"nvim-telescope/telescope.nvim",
	config = function()
		require("user.modules.telescope.config").telescope()
	end,
	requires = { "nvim-lua/plenary.nvim" },
})
