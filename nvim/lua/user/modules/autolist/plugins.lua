local plugin = require("user.pack").register_plugin

plugin({
	"gaoDean/autolist.nvim",
	config = function()
		require("user.modules.autolist.config").autolist()
	end,
})
