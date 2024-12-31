---Setup terminal keymaps
---This will get called by ToggleTerm when a terminal is opened, I guess?
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-j>", [[<C-\><C-n>]], opts)
end

return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = true,
		keys = { [[<c-\>]], "<c-j>" },
		opts = {
			open_mapping = { [[<c-\>]], "<c-j>" },
		},
	},
	{
		"samjwill/nvim-unception",
	},
}
