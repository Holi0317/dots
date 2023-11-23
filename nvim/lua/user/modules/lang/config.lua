local M = {}

function M.mason()
	require("mason").setup()

	require("mason-tool-installer").setup({
		-- a list of all tools you want to ensure are installed upon
		-- start; they should be the names Mason uses for each tool
		ensure_installed = {
			"dockerfile-language-server",
			"vim-language-server",

			-- Bash and shell
			"bash-language-server",
			"shellcheck",
			"shfmt",

			-- C and C++
			"clangd",
			"cmake-language-server",

			-- Go
			"gopls",
			"golangci-lint",

			-- Python
			"pyright",
			"ruff-lsp",

			-- Lua
			"lua-language-server",
			"stylua",

			-- Rust
			"rust-analyzer",

			-- JSON, yaml, toml
			"json-lsp",
			"yaml-language-server",
			"ansible-language-server",
			"taplo",

			-- Terraform
			"terraform-ls",
			"tflint",

			-- Typescript and the web
			"css-lsp",
			"html-lsp",
			"typescript-language-server",
			"eslint_d",
			"prettierd",
			"vue-language-server",
			"emmet-ls",
			"astro-language-server",

			-- XML
			"lemminx",

			-- Non-language
			"editorconfig-checker",
			"marksman",
		},
	})
end

function M.lspconfig()
	require("mason-lspconfig").setup()
end

function M.neodev()
	require("neodev").setup({
		-- add any options here, or leave empty to use the default settings
	})
end

function M.null()
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
			null.builtins.code_actions.eslint_d.with({
				extra_filetypes = { "astro" },
			}),
			null.builtins.code_actions.shellcheck,

			null.builtins.diagnostics.eslint_d.with({
				extra_filetypes = { "astro" },
			}),
			null.builtins.diagnostics.flake8,
			null.builtins.diagnostics.golangci_lint,
			null.builtins.diagnostics.shellcheck,

			null.builtins.formatting.black,
			null.builtins.formatting.eslint_d.with({
				extra_filetypes = { "astro" },
			}),
			null.builtins.formatting.gofmt,
			null.builtins.formatting.goimports,
			null.builtins.formatting.isort,
			null.builtins.formatting.prettierd,
			null.builtins.formatting.shfmt,
			null.builtins.formatting.stylua,
			null.builtins.formatting.taplo,
			null.builtins.formatting.rustfmt,
		},
	})
end

function M.format()
	require("lsp-format").setup({})

	-- Fix `:wq` as we need to do the formatting in sync
	vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
end

function M.fidget()
	require("fidget").setup({
		text = {
			spinner = "dots_negative",
		},
	})
end

function M.saga()
	local saga = require("lspsaga")

	saga.setup({
		outline = {
			auto_preview = false,
		},
		code_action = {
			keys = {
				quit = { "<esc>", "q" },
			},
		},
		rename = {
			quit = "<C-c>",
		},
	})

	local signs = {
		Error = " ",
		Warn = " ",
		Info = " ",
		Hint = "󰌶 ",
	}
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

function M.aerial()
	require("aerial").setup()
end

function M.gnupg()
	vim.g.GPGPreferSign = 1

	vim.api.nvim_create_autocmd("User", {
		pattern = "GnuPG",
		callback = require("user.plugins.redact").redact_once,
	})
end

return M
