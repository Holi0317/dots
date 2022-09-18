local plugin = require("user.pack").register_plugin

plugin({
	"numToStr/Comment.nvim",
	config = function()
		require("user.modules.editing.config").comment()
	end,
})

plugin({
	"gaoDean/autolist.nvim",
	config = function()
		require("user.modules.editing.config").autolist()
	end,
})
