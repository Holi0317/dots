local plugin = require("user.pack").register_plugin

plugin({
	"folke/which-key.nvim",
	config = function()
		require('user.modules.keys.config').whichkey()
	end
})
