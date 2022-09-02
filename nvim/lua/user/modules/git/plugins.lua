local plugin = require("user.pack").register_plugin


plugin({
	"lewis6991/gitsigns.nvim",
	config = function()
		require("user.modules.git.config").gitsigns()
	end,
})

plugin({
	"tpope/vim-fugitive",
	cmd = {
		"G",
		"Git",
		"Gdiffsplit",
		"Gread",
		"Gwrite",
		"Ggrep",
		"GMove",
		"GDelete",
		"GBrowse",
		"GRemove",
		"GRename",
		"Glgrep",
		"Gedit",
	},
	ft = { "fugitive" },
})
