-- Need to wait for packer to load flutter plugin first
vim.defer_fn(function()
	require("telescope").load_extension("flutter")
end, 10)
