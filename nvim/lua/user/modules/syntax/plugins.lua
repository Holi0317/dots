local plugin = require("user.pack").register_plugin

plugin({
	"nvim-treesitter/nvim-treesitter",
	run = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
	config = function()
		require("user.modules.syntax.config").treesitter()
	end,
	-- Put extra modules in `requires` to make sure our config is picking them up
	-- correctly
	requires = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/playground",
		"theHamsta/nvim-treesitter-pairs",
		"adelarsq/vim-matchit", -- Required by pairs
		"nvim-treesitter/nvim-treesitter-context",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
})

-- TODO(0.8): Remove spellsitter as it is now native.
plugin({
	"lewis6991/spellsitter.nvim",
	config = function()
		require("user.modules.syntax.config").spellsitter()
	end,
})
