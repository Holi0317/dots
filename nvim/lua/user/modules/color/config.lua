local M = {}

function M.gruvbox()
	vim.o.background = "dark" -- or "light" for light mode
	require("gruvbox").setup({
		contrast = "hard", -- can be "hard" or "soft"
		overrides = {
			Operator = { link = "GruvboxRed" },
			SignColumn = { bg = "none" },
			SpellBad = { link = "GruvboxAquaUnderline" },
			IndentBlanklineContextChar = { link = "GruvboxBlue" },

			LuasnipInsertNodePassive = { link = "GurvoxRed" },
			LuasnipSnippetPassive = { link = "GruvboxBlue" },
		},
	})

	vim.cmd("colorscheme gruvbox")
end

return M
