local plugin = require("user.pack").register_plugin

plugin({
	"windwp/nvim-autopairs",
	config = function()
		require("user.modules.textobj.config").autopairs()
	end,
})

plugin({
	"tpope/vim-repeat",
})

plugin({
	"Julian/vim-textobj-variable-segment",
	requires = {
		"kana/vim-textobj-user",
	},
})

plugin({
	"kana/vim-textobj-line",
	requires = {
		"kana/vim-textobj-user",
	},
})

plugin({
	"tpope/vim-surround",
})

plugin({
	"gbprod/substitute.nvim",
	config = function()
		require("user.modules.textobj.config").substitute()
	end,
})
