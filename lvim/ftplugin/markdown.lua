-- Bind Markdown-specific keys (zk stuff) to `\` key
local wk = require("which-key")

local current_buf = vim.api.nvim_get_current_buf()

-- Show color column at 90
vim.bo.textwidth = 90

vim.schedule(function()
	local zkutil = require("zk.util")

	if zkutil.notebook_root(vim.fn.expand("%:p")) == nil then
		return
	end

	wk.register({
		name = "zk",
		n = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New note" },
		o = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Open note" },
	}, {
		prefix = "\\",
		buffer = current_buf,
	})
end)
