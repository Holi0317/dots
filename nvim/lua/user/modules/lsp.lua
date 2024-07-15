return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = true,
	},

	{
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},

	{
		"lukas-reineke/lsp-format.nvim",
		config = function()
			require("lsp-format").setup({})

			-- Fix `:wq` as we need to do the formatting in sync
			vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
		end,
	},

	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"lukas-reineke/lsp-format.nvim",
		},
		config = function()
			local null = require("null-ls")
			local lspformat = require("lsp-format")
			local callbacks = require("user.lsp.callbacks")

			null.setup({
				on_attach = function(client, bufnr)
					lspformat.on_attach(client)

					callbacks.on_attach(client, bufnr)
				end,
				on_init = callbacks.on_init,
				on_exit = callbacks.on_exit,
				sources = {
					null.builtins.diagnostics.golangci_lint,

					null.builtins.formatting.gofmt,
					null.builtins.formatting.goimports,
					null.builtins.formatting.prettierd.with({
						extra_filetypes = { "mdx" },
					}),
					null.builtins.formatting.shfmt,
					null.builtins.formatting.stylua,
				},
			})
		end,
	},

	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc", "yaml", "toml" },
	},
}
