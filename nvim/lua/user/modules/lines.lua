return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("user.lines").lualine()
		end,
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("user.lines").bufferline()
		end,
	},

	{
		"ojroques/nvim-bufdel",
		lazy = true,
		cmd = {
			"BufDel",
			"BufDelAll",
			"BufDelOthers",
		},
	},
}
