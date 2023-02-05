local plugin = require("user.pack").register_plugin

plugin({
	"rcarriga/nvim-notify",
	config = function()
		reuqire("user.modules.ui.config").notify()
	end
})
