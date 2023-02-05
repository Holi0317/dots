local M = {}

function M.project()
	require("project_nvim").setup({
		detection_methods = { "pattern" },
		patterns = { ".git", ".obsidian" },
		ignore_lsp = {
			"null-ls",
		},
	})
end

function M.projectlocal()
	require("config-local").setup({
		-- Default configuration (optional)
		config_files = { ".vimrc.lua", ".vimrc" }, -- Config file patterns to load (lua supported)
		hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
		autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
		commands_create = true, -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
		silent = false, -- Disable plugin messages (Config loaded/ignored)
		lookup_parents = true, -- Lookup config files in parent directories
	})
end

return M
