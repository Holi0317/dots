return {
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"tpope/vim-repeat",
	},
	{
		"Julian/vim-textobj-variable-segment",
		dependencies = {
			"kana/vim-textobj-user",
		},
	},
	{
		"kana/vim-textobj-line",
		dependencies = {
			"kana/vim-textobj-user",
		},
	},
	{
		"tpope/vim-surround",
	},
	{
		"gbprod/substitute.nvim",
		lazy = true,
		keys = {
			{
				"gs",
				function()
					require("substitute").operator()
				end,
				noremap = true,
			},
			{
				"gss",
				function()
					require("substitute").line()
				end,
				noremap = true,
			},
			{
				"gS",
				function()
					require("substitute").eol()
				end,
				noremap = true,
			},
			{
				"gs",
				function()
					require("substitute").visual()
				end,
				mode = "x",
				noremap = true,
			},
		},
		config = true,
	},
}
