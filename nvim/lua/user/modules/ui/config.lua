local M = {}

function M.notify()
	local notify = require("notify")
	local keys = require("user.keys")
	local telescope = require("telescope")

	vim.notify = notify
end

function M.dressing()
	require("dressing").setup({
		input = {
			enabled = true,

			-- When true, <Esc> will close the modal
			insert_only = false,
		},
		select = {
			-- Set to false to disable the vim.ui.select implementation
			enabled = true,
		},
	})
end

function M.trouble()
	require("trouble").setup()

	vim.keymap.set('n', ']t', function() 
		require("trouble").next({ skip_groups = true, jump = true })
	end)

	vim.keymap.set('n', '[t', function() 
		require("trouble").previous({ skip_groups = true, jump = true })
	end)
end

return M
