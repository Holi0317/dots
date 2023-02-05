local plugin = require("user.pack").register_plugin

plugin({
	"rcarriga/nvim-notify",
	config = function()
		require("user.modules.ui.config").notify()
	end
})

plugin({
	"stevearc/dressing.nvim",
	config = function()
		require("user.modules.ui.config").dressing()
	end
})
