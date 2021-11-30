local M = {}

local function force_buf_remap(buffer, mode, lhs, rhs, opts)
	local opts_ = opts or {}

	vim.defer_fn(function()
		vim.api.nvim_buf_del_keymap(buffer, mode, lhs)

		vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts_)
	end, 100)
end

function M.markdown()
	local wk = require("which-key")
	local current_buf = vim.api.nvim_get_current_buf()
	wk.register({
		name = "Telekasten",
		n = { "<cmd>lua require('telekasten').new_note()<CR>", "New note" },
		N = { "<cmd>lua require('telekasten').new_templated_note()<CR>", "New note from template" },
		t = { "<cmd>lua require('telekasten').goto_today()<CR>", "Goto today" },
		c = { "<cmd>lua require('telekasten').show_calendar()<CR>", "Show calendar" },
		C = { "<cmd>CalendarT<CR>", "Show big calendar" },
		z = { "<cmd>lua require('telekasten').follow_link()<CR>", "Follow link" },
		b = { "<cmd>lua require('telekasten').show_backlinks()<CR>", "Show backlink" },
		f = { "<cmd>lua require('telekasten').find_friends()<CR>", "Find friends" },
		["["] = { "<cmd>lua require('telekasten').insert_link()<CR>", "Insert link" },
	}, {
		prefix = "\\",
		buffer = current_buf,
	})

	vim.api.nvim_buf_set_keymap(
		0,
		"i",
		"\\[",
		"<ESC>:lua require('telekasten').insert_link({ i=true })<CR>",
		{ silent = true }
	)

	force_buf_remap(
		current_buf,
		"",
		"gd",
		"<cmd>lua require('telekasten').follow_link()<CR>",
		{ silent = true, noremap = true }
	)
end

return M
