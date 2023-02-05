local plugin = require("user.pack").register_plugin

plugin({
	"ellisonleao/gruvbox.nvim",
	config = function()
		require("user.modules.color.config").gruvbox()
	end,
})
