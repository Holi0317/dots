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

plugin({
	"jghauser/mkdir.nvim",
})

plugin({
	"gpanders/editorconfig.nvim",
})

plugin({
	"ethanholz/nvim-lastplace",
	event = "BufRead",
	config = function()
		require("user.modules.editing.config").lastplace()
	end,
})
