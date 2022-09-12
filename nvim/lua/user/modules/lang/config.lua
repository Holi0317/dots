local M = {}

function M.mason()
	require("mason").setup()

	require('mason-tool-installer').setup {
		-- a list of all tools you want to ensure are installed upon
		-- start; they should be the names Mason uses for each tool
		ensure_installed = {
			'dockerfile-language-server',
			'vim-language-server',

			-- Bash and shell
			'bash-language-server',
			'shellcheck',
			'shfmt',

			-- C and C++
			'clangd',
			'cmake-language-server',

			-- C#
			'omnisharp',
			'netcoredbg',

			-- Go
			'gopls',
			'golangci-lint',
			'delve',

			-- Python
			'pyright',
			'isort',
			'black',
			'debugpy',

			-- Lua
			'lua-language-server',
			'stylua',

			-- JSON, yaml, toml
			'json-lsp',
			'fixjson',
			'yaml-language-server',
			'ansible-language-server',
			'taplo',

			-- Typescript and the web
			'css-lsp',
			'html-lsp',
			'typescript-language-server',
			'eslint_d',
			'prettierd',
			'vue-language-server',
			'emmet-ls',

			-- Non-language
			'editorconfig-checker',
		},
	}
end

function M.lspconfig()
	require("mason-lspconfig").setup()
end

function M.luadev()
	require("lua-dev").setup({
		-- add any options here, or leave empty to use the default settings
	})
end

return M
