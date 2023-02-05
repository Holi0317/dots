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

function M.autolist()
	local autolist = require("autolist")
	autolist.setup()
	autolist.create_mapping_hook("i", "<CR>", autolist.new)
	autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
	autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
	autolist.create_mapping_hook("n", "o", autolist.new)
	autolist.create_mapping_hook("n", "O", autolist.new_before)
	autolist.create_mapping_hook("n", ">>", autolist.indent)
	autolist.create_mapping_hook("n", "<<", autolist.indent)
	autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
	autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
	vim.api.nvim_create_autocmd("TextChanged", {
		pattern = "*",
		callback = function()
			vim.cmd.normal({ autolist.force_recalculate(nil, nil), bang = false })
		end,
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
