return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = {
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
				-- Can't install on arch because python is too new...
				-- "cmake-language-server",

				-- Go
				"gopls",
				"golangci-lint",

				-- Python
				"pyright",
				"ruff",

				-- PHP
				"intelephense",

				-- Lua
				"lua-language-server",
				"stylua",

				-- Rust
				"rust-analyzer",

				-- JSON, yaml, toml
				"json-lsp",
				"yaml-language-server",
				"taplo",

				-- Terraform
				"terraform-ls",
				"tflint",

				-- Ansible
				"ansible-language-server",
				"ansible-lint",

				-- Typescript and the web
				"css-lsp",
				"html-lsp",
				"typescript-language-server",
				"eslint-lsp",
				"prettierd",
				"vue-language-server",
				"emmet-ls",
				"astro-language-server",
				"tailwindcss-language-server",

				-- XML
				"lemminx",

				-- Non-language
				"editorconfig-checker",
				"marksman",
				"tinymist",
			},
		},
	},
}
