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

plugin({
	"folke/trouble.nvim",
	config = function()
		require("user.modules.ui.config").trouble()
	end,
})

plugin({
	"gbprod/yanky.nvim",
	config = function()
		require("user.modules.ui.config").yanky()
	end,
})


-- ==== Indent line visual ====
plugin({
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("user.modules.ui.config").indent()
	end,
})

