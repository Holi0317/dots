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
			-- Use nu when neovim is called under nu.
			-- Cannot change my shell in some cases but I still want terminal in nu.
			shell = function()
				-- Already set to nu
				if vim.endswith(vim.o.shell, "/nu") then
					return vim.o.shell
				end

				-- Probably was called under nu if this env is set
				local nu_version = os.getenv("NU_VERSION")
				if nu_version then
					return "nu"
				end

				return vim.o.shell
			end,
		},
	},
	{
		"samjwill/nvim-unception",
	},
}
