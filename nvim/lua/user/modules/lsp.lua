return {
	{
		"neovim/nvim-lspconfig",
		requires = {
			"saghen/blink.cmp",
		},
		config = function()
			-- Ref: https://github.com/vuejs/language-tools/wiki/Neovim
			-- Tool is managed by mise; @vue/typescript-plugin is co-installed via
			-- pnpm_args. pnpm hoists each into its own v11/<hash>/node_modules/@vue/
			-- dir, so they're NOT siblings. Pointing `location` at typescript-plugin
			-- itself lets tsserver's require.resolve walk up and find it.
			local lsp_paths = require("user.lsp.paths")
			local vue_lsp_path = lsp_paths.find_module("npm:@vue/language-server", "@vue/typescript-plugin")
			local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_lsp_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			vim.lsp.config("ts_ls", {
				filetypes = tsserver_filetypes,
				init_options = {
					plugins = {
						vue_plugin,
					},
				},
			})
			vim.lsp.config("vue_ls", {})

			-- List of enabled lsp, via lspconfig name
			local enabled = {
				-- Managed via mise. Sync with mise.toml
				"ansiblels",
				"astro",
				"bashls",
				"cssls",
				"denols",
				"dockerls",
				"emmet_ls",
				"eslint",
				"gopls",
				"html",
				"jsonls",
				"lemminx",
				"lua_ls",
				"marksman",
				"pyright",
				"ruff",
				"stylua",
				"taplo",
				"terraformls",
				"tflint",
				"tinymist",
				"ts_ls",
				-- "vue_ls",
				"yamlls",

				-- Outside mise, or per-project
				"nushell",
				"dartls",
			}

			for _, lang in ipairs(enabled) do
				vim.lsp.enable(lang)
			end

			require("user.lsp.callbacks").setup()
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
					null.builtins.diagnostics.actionlint,

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
