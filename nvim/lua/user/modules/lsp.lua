return {
	{
		"mason-org/mason-lspconfig.nvim",
		config = true,
	},

	{
		"neovim/nvim-lspconfig",
		requires = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- Ref: https://github.com/vuejs/language-tools/issues/3925
			local ts_plugin_path = vim.fn.expand(
				"$MASON/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
			)

			vim.lsp.config("ts_ls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = ts_plugin_path,
							languages = { "javascript", "typescript", "vue" },
						},
					},
				},
			})

			require("user.lsp.callbacks").setup()

			-- No need to call lsp.enable here. williamboman/mason-lspconfig.nvim will
			-- do enable for us.
			--
			-- ... Except lsp not managed by mason
			vim.lsp.enable("nushell")
			vim.lsp.enable("dartls")
		end,
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
			local callbacks = require("user.lsp.callbacks")

			null.setup({
				on_attach = function(client, bufnr)
					callbacks.on_attach(client, bufnr)
				end,
				sources = {
					null.builtins.diagnostics.golangci_lint.with({
						runtime_condition = function(params)
							-- Do not run under ~/go.
							--
							-- Had some issue with cloudflare go sdk and golangci-lint will do
							-- a fork bomb for some reason. Maybe they got too many
							-- files/symbols under the package.
							--
							-- Anyway we don't need any linting for third party library
							-- anyway. So just don't do that.
							return vim.fs.relpath("~/go", params.bufname) == nil
						end,
					}),

					null.builtins.formatting.gofmt,
					null.builtins.formatting.goimports,
					null.builtins.formatting.prettierd.with({
						extra_filetypes = { "mdx" },
					}),
					null.builtins.formatting.shfmt,
					null.builtins.formatting.stylua,
					null.builtins.formatting.hclfmt.with({
						extra_filetypes = { "terraform-vars" },
					}),
				},
			})
		end,
	},

	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc", "yaml", "toml" },
		config = function()
			local schemastore = require("schemastore")

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = schemastore.json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
	},
}
