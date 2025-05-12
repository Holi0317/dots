return {
	{
		"mason-org/mason.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
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
				-- "clangd",
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

				-- JSON, yaml, toml
				"json-lsp",
				"yaml-language-server",
				"taplo",
				"actionlint",

				-- Terraform
				"terraform-ls",
				"tflint",
				"hclfmt",

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
