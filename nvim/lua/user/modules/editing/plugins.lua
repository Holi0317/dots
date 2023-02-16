local plugin = require("user.pack").register_plugin

plugin({
	"numToStr/Comment.nvim",
	config = function()
		require("user.modules.editing.config").comment()
	end,
})

plugin({
	"gaoDean/autolist.nvim",
	ft = { "markdown", "text", "tex", "plaintex" },
	requires = {
		-- Force autolist load after autopairs to fix autolist
		-- See gaoDean/autolist.nvim#43
		"windwp/nvim-autopairs",
	},
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
