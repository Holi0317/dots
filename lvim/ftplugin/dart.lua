-- Need to wait for packer to load flutter plugin first
vim.defer_fn(function()
	local telescope = require("telescope")
	local wk = require("which-key")

	telescope.load_extension("flutter")

	wk.register({
		F = {
			function()
				telescope.extensions.flutter.commands()
			end,
			"Flutter",
		},
	}, { prefix = "<leader>s" })
end, 10)
