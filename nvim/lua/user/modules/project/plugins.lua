local plugin = require("user.pack").register_plugin

plugin({
	"ahmedkhalf/project.nvim",
	config = function()
		require("user.modules.project.config").project()
	end,
})

plugin({
	"klen/nvim-config-local",
	config = function()
		require("user.modules.project.config").projectlocal()
	end,
})
