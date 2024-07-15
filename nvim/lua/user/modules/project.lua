return {
	{
		"ahmedkhalf/project.nvim",
		main = "project_nvim",
		opts = {
			detection_methods = { "pattern" },
			patterns = { ".git", ".obsidian" },
			ignore_lsp = {
				"null-ls",
			},
		},
	},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = {
				"gitcommit",
				"gitrebase",
				"fugitive",
			},
			lastplace_open_folds = true,
		},
	},
}
