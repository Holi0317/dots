return {
	{
		"numToStr/Comment.nvim",
		lazy = true,
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		keys = { "tcc" },
		opts = function()
			require("Comment").setup({
				toggler = {
					line = "tcc",
					block = "tbc",
				},
				opleader = {
					---Line-comment keymap
					line = "tc",
					---Block-comment keymap
					block = "tb",
				},
				extra = {
					---Add comment on the line above
					above = "tcO",
					---Add comment on the line below
					below = "tco",
					---Add comment at the end of line
					eol = "tcA",
				},
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}
