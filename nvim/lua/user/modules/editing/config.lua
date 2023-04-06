local M = {}

function M.comment()
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
end

function M.lastplace()
	require("nvim-lastplace").setup({
		lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
		lastplace_ignore_filetype = {
			"gitcommit",
			"gitrebase",
			"fugitive",
		},
		lastplace_open_folds = true,
	})
end

return M
