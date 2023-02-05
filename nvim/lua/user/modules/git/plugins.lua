local plugin = require("user.pack").register_plugin


plugin({
	"lewis6991/gitsigns.nvim",
	config = function()
require("user.modules.git.config").gitsigns()
	end,
})
