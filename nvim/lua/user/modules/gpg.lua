return {
	{
		"jamessan/vim-gnupg",
		config = function()
			vim.g.GPGPreferSign = 1

			vim.api.nvim_create_autocmd("User", {
				pattern = "GnuPG",
				callback = require("user.plugins.redact").redact_once,
			})
		end,
	},
}
