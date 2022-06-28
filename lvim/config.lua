local deferwk = require("h4s.deferwk")

-- Additional plugins
table.insert(lvim.plugins, { "tpope/vim-repeat" })
table.insert(lvim.plugins, { "dkarter/bullets.vim" })
table.insert(lvim.plugins, { "jghauser/mkdir.nvim" })
table.insert(lvim.plugins, {
	"folke/lsp-colors.nvim",
	event = "BufRead",
})

-- ==== general ====
-- Aka I have no idea where to put these options
lvim.log.level = "warn"
lvim.format_on_save = {
	---@usage pattern string pattern used for the autocommand (Default: '*')
	pattern = "*",
	---@usage timeout number timeout in ms for the format request (Default: 1000)
	timeout = 5000,
	---@usage filter func to select client
	filter = require("lvim.lsp.handlers").format_filter,
}

-- Show colorcolumn on textwidth + 1. (currently) Used in markdown only.
vim.wo.colorcolumn = "+1"
-- Disable startup greeter
lvim.builtin.alpha.active = false

-- ==== Colorscheme configuration ====
table.insert(lvim.plugins, { "sainnhe/gruvbox-material" })
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_sign_column_background = "none"
lvim.colorscheme = "gruvbox-material"

-- ==== Keybindings [view all the defaults by pressing <leader>Lk] ====
lvim.leader = " "
vim.opt.timeoutlen = 1000

-- ==== Keybindings: Disable esc keybindings from lvim ====
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false

-- ==== Keybindings: buffer navigation and actions ====
lvim.keys.normal_mode["]b"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["[b"] = ":BufferLineCyclePrev<CR>"
lvim.builtin.which_key.mappings["b"] = {
	name = "Buffers",

	j = { "<cmd>BufferLinePick<cr>", "Jump" },
	f = { "<cmd>Telescope buffers<cr>", "Find" },
	l = { "<cmd>Telescope buffers<cr>", "Find" },
	b = { "<cmd>b#<cr>", "Previous" },

	-- Wait what's difference between BufferDelete and BufferWipeout
	w = { "<cmd>BufferWipeout<cr>", "Wipeout/Delete current buffer" },
	d = { "<cmd>BufferKill<cr>", "Delete current buffer" },

	o = {
		"<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
		"Close all but current",
	},
	H = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
	L = {
		"<cmd>BufferLineCloseRight<cr>",
		"Close all to the right",
	},
	s = {
		name = "Sort by...",
		d = { "<cmd>BufferOrderByDirectory<cr>", "Sort by directory" },
		l = { "<cmd>BufferOrderByLanguage<cr>", "Sort by language" },
		w = { "<cmd>BufferOrderByWindowNumber<cr>", "Sort by window number" },
	},
}

-- ==== Keybindings: Tab navigation ====
lvim.keys.normal_mode["]T"] = ":tabn<cr>"
lvim.keys.normal_mode["[T"] = ":tabp<cr>"
lvim.keys.normal_mode["tn"] = ":tabnew %<cr>"

-- ==== Keybindings: Add line above/under cursor ====
lvim.keys.normal_mode["[<space>"] = ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'["
lvim.keys.normal_mode["]<space>"] = ":<c-u>put =repeat(nr2char(10), v:count1)<cr>"

-- ==== Keybindings: Conceal toggle ====
lvim.keys.normal_mode["<C-c>"] = "<cmd>lua require('h4s.conceal').toggle()<CR>"

-- ==== Keybindings: LSP-related ====
deferwk.register({
	["i"] = {
		function()
			vim.diagnostic.goto_prev({ popup_opts = { border = lvim.lsp.popup_border } })
		end,
		"Previous Diagnostic",
	},
}, { prefix = "[" })
deferwk.register({
	["i"] = {
		function()
			vim.diagnostic.goto_next({ popup_opts = { border = lvim.lsp.popup_border } })
		end,
		"Next Diagnostic",
	},
}, { prefix = "]" })

-- Note: This table will be mutated later in this file
-- Search for usage of `lsp_keybinds` to see where will mutate this table.
local lsp_keybinds = {
	name = "LSP",

	a = {
		function()
			vim.lsp.buf.code_action()
		end,
		"Code Action",
	},
	d = {
		"<cmd>TroubleToggle document_diagnostics<cr>",
		"Document Diagnostics",
	},
	w = {
		"<cmd>TroubleToggle workspace_diagnostics<cr>",
		"Workspace Diagnostics",
	},
	f = {
		function()
			vim.lsp.buf.formatting()
		end,
		"Format",
	},
	i = { "<cmd>LspInfo<cr>", "Info" },
	I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
	j = {
		function()
			vim.diagnostic.goto_next({ popup_opts = { border = lvim.lsp.popup_border } })
		end,
		"Next Diagnostic",
	},
	k = {
		function()
			vim.diagnostic.goto_prev({ popup_opts = { border = lvim.lsp.popup_border } })
		end,
		"Prev Diagnostic",
	},
	l = {
		function()
			vim.lsp.codelens.run()
		end,
		"CodeLens Action",
	},
	p = {
		name = "Peek",
		d = {
			function()
				require("lvim.lsp.peek").Peek("definition")
			end,
			"Definition",
		},
		t = {
			function()
				require("lvim.lsp.peek").Peek("typeDefinition")
			end,
			"Type Definition",
		},
		i = {
			function()
				require("lvim.lsp.peek").Peek("implementation")
			end,
			"Implementation",
		},
	},
	q = {
		function()
			vim.diagnostic.set_loclist()
		end,
		"Quickfix",
	},
	r = {
		function()
			vim.lsp.buf.rename()
		end,
		"Rename",
	},
	R = {
		function()
			local name = vim.api.nvim_buf_get_name(0)
			vim.ui.input({
				prompt = "New filename",
				default = name,
			}, function(input)
				if input == nil then
					return
				end

				if input == name then
					return
				end

				vim.lsp.util.rename(name, input)
			end)
		end,
		"Rename file",
	},
	S = {
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		"Workspace Symbols",
	},
}

deferwk.register(lsp_keybinds, { prefix = ";" })
lvim.builtin.which_key.mappings.l = lsp_keybinds

-- Make `K` dap-aware
lvim.lsp.buffer_mappings.normal_mode.K = {
	function()
		local dap = require("dap")
		local widgets = require("dap.ui.widgets")
		if dap.session() == nil then
			vim.lsp.buf.hover()
		else
			widgets.hover()
		end
	end,
	"Show hover",
}

-- ==== Git ====
table.insert(lvim.plugins, {
	"tpope/vim-fugitive",
	cmd = {
		"G",
		"Git",
		"Gdiffsplit",
		"Gread",
		"Gwrite",
		"Ggrep",
		"GMove",
		"GDelete",
		"GBrowse",
		"GRemove",
		"GRename",
		"Glgrep",
		"Gedit",
	},
	ft = { "fugitive" },
})

-- ==== Relative numberline ====
vim.opt.relativenumber = true
lvim.autocommands.relnumber_toggle = {
	{ "InsertEnter", "*", "set norelativenumber" },
	{ "InsertLeave", "*", "set relativenumber" },
}

-- ==== Comment settings ====
lvim.builtin.comment.toggler = {
	line = "tcc",
	block = "tbc",
}

lvim.builtin.comment.opleader = {
	line = "tc",
	block = "tb",
}

-- Disable "-cro" autocommand in lvim
lvim.autocommands._formatoptions = {}

-- ==== Save and format on save ====
lvim.builtin.which_key.mappings["W"] = {
	function()
		local autocmds = require("lvim.core.autocmds")

		autocmds.disable_format_on_save()
		vim.schedule(function()
			vim.cmd(":w")
			autocmds.enable_format_on_save()
		end)
	end,
	"Save without format",
}

-- ==== Spelling ====
table.insert(lvim.plugins, { "f3fora/cmp-spell" })
table.insert(lvim.builtin.cmp.sources, { name = "spell" })

table.insert(lvim.plugins, {
	"lewis6991/spellsitter.nvim",
	config = function()
		require("spellsitter").setup()
	end,
})

-- ==== Emoji ====
table.insert(lvim.plugins, { "hrsh7th/cmp-emoji" })

vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spelllang = { "en_us" }

-- ==== Add omni for nvim-cmp ====
table.insert(lvim.plugins, { "hrsh7th/cmp-omni" })
table.insert(lvim.builtin.cmp.sources, { name = "omni" })

-- ==== DocString generator ====
table.insert(lvim.plugins, {
	"danymat/neogen",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
		})
	end,
})

-- ==== Better UI ====
table.insert(lvim.plugins, {
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
			input = {
				enabled = true,

				-- When true, <Esc> will close the modal
				insert_only = false,
			},
			select = {
				-- Set to false to disable the vim.ui.select implementation
				enabled = true,
			},
		})
	end,
})

-- ==== Notification ====
lvim.builtin.notify.active = true

lvim.builtin.which_key.mappings.s.n = {
	function()
		require("telescope").extensions.notify.notify()
	end,
	"Notifications",
}

-- ==== Sudo write ====
vim.cmd(":ca w!! lua require('h4s.sudo').sudo_write()")

-- ==== Editorconfig ====
table.insert(lvim.plugins, { "gpanders/editorconfig.nvim" })

-- ==== redact ====
require("h4s.redact").setup()

-- ==== Telescope (Fuzzy searcher) ====
lvim.keys.normal_mode["<C-p>"] = ":Telescope find_files<cr>"
-- Show hidden file in find_files picker
lvim.builtin.telescope.pickers = {
	find_files = {
		find_command = { "fd", "--type=file", "--hidden", "-E", ".git" },
	},
}
-- <C-u> in telescope (insert mode) clears the search field
lvim.builtin.telescope.defaults.mappings.i["<C-u>"] = function()
	vim.fn.setline(".", "")
end

-- ==== Lualine (status line) ====
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_b = {
	components.branch,
	vim.tbl_extend("force", components.filename, {
		path = 1,
	}),
}

lvim.builtin.lualine.sections.lualine_x = {
	components.diagnostics,
	components.lsp,
	components.treesitter,
	components.location,
	{
		"filetype",
		icon_only = true,
	},
}

-- ==== Project (auto cd to project root directory) ====
vim.list_extend(lvim.builtin.project.patterns, {
	".obsidian",
})
lvim.builtin.project.ignore_lsp = {
	"null-ls",
}

-- ==== Project-specific configuration ====
table.insert(lvim.plugins, {
	"klen/nvim-config-local",
	config = function()
		require("config-local").setup({
			-- Default configuration (optional)
			config_files = { ".vimrc.lua", ".vimrc" }, -- Config file patterns to load (lua supported)
			hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
			autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
			commands_create = true, -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
			silent = false, -- Disable plugin messages (Config loaded/ignored)
			lookup_parents = true, -- Lookup config files in parent directories
		})
	end,
})

-- ==== Surround ====
table.insert(lvim.plugins, { "tpope/vim-surround" })

-- ==== Lightspeed ====
table.insert(lvim.plugins, { "ggandor/lightspeed.nvim", opt = true })
deferwk.on_done(function()
	-- We need to load this after deferwk finish and unmap the `nmap ;` binding.
	-- The binding is conflicting with which-key and somehow which-key is not registering it at this moment
	vim.cmd("PackerLoad lightspeed.nvim")

	vim.api.nvim_del_keymap("n", ";")
end)

-- ==== Indent line visual ====
table.insert(lvim.plugins, {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("indent_blankline").setup({
			show_current_context = true,
			show_current_context_start = true,
		})
	end,
})

-- ==== .gpg extension support ====
table.insert(lvim.plugins, { "jamessan/vim-gnupg" })
vim.g.GPGPreferSign = 1

lvim.autocommands.gpgenter = {
	{ "User", "GnuPG", "lua require('h4s.redact').redact_once()" },
}

-- ==== Remember where I left off ====
table.insert(lvim.plugins, {
	"ethanholz/nvim-lastplace",
	event = "BufRead",
	config = function()
		require("nvim-lastplace").setup({
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = {
				"gitcommit",
				"gitrebase",
				"svn",
				"hgcommit",
			},
			lastplace_open_folds = true,
		})
	end,
})

-- ==== Todo enhancement ====
table.insert(lvim.plugins, {
	"folke/todo-comments.nvim",
	event = "BufRead",
	config = function()
		require("todo-comments").setup()
	end,
})

-- Need to rebind text search as it was bind to "t" key
lvim.builtin.which_key.mappings.s.g = { "<cmd>Telescope live_grep<cr>", "Grep" }
lvim.builtin.which_key.mappings.s.t = { "<cmd>TodoTelescope<cr>", "TODO" }

-- ==== LSP ====

-- ==== LSP: Signature popup ====
table.insert(lvim.plugins, { "ray-x/lsp_signature.nvim" })
-- Somehow putting this in config callback in packer does not work
local ok, lsp_signature = pcall(require, "lsp_signature")
if ok then
	lsp_signature.setup()
end

-- ==== LSP: Symbols outline ====
table.insert(lvim.plugins, {
	"simrat39/symbols-outline.nvim",
	cmd = "SymbolsOutline",
})

lsp_keybinds.s = { "<cmd>SymbolsOutline<cr>", "Document Symbols" }

-- ==== LSP: Trouble ====
table.insert(lvim.plugins, {
	"folke/trouble.nvim",
	cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
})
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
	t = { "<cmd>TodoTrouble<cr>", "Todo" },
}

lvim.keys.normal_mode["]t"] = function()
	require("trouble").next({ skip_groups = true, jump = true })
end
lvim.keys.normal_mode["[t"] = function()
	require("trouble").previous({ skip_groups = true, jump = true })
end

-- Use trouble for some lsp keys
lvim.lsp.buffer_mappings.normal_mode = vim.tbl_extend("force", lvim.lsp.buffer_mappings.normal_mode, {
	-- Use lsp goto definition until trouble is fixed.
	-- Ref: https://github.com/folke/trouble.nvim/issues/153
	-- gd = { "<cmd>Trouble lsp_definitions<CR>", "Goto Definition" },
	gd = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
	gr = { "<cmd>Trouble lsp_references<CR>", "Goto references" },
	gI = { "<cmd>Trouble lsp_implementations<CR>", "Goto Implementation" },
	gt = { vim.lsp.buf.type_definition, "Goto type definition" },
})

-- ==== DAP ====
require("h4s.dap").setup()

-- ==== Formatters ====
-- Disable some formatters from LSP
local block_formatter = require("h4s.block_formatter")
lvim.lsp.on_init_callback = block_formatter.mk_block_formatter({
	"sumneko_lua",
	"gopls",
	"jsonls",
	"volar",
	"vue",
	"tsserver",
})

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "stylua" },
	{ exe = "prettier" },
	{ exe = "gofmt" },
	{ exe = "goimports" },
	{ exe = "eslint_d" },
})

-- ==== Linters ====

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "golangci-lint" },
	{ exe = "eslint_d" },
})

-- ==== Treesitter ====
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"rust",
	"java",
	"yaml",
}

lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent = {
	enable = true,
	-- Some language's indentation in ts is broken
	disable = { "go" },
}

-- ==== Treesitter: Auto close HTML/XML tag ====
table.insert(lvim.plugins, {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup()
	end,
})

-- Treesitter: Playground ====
table.insert(lvim.plugins, { "nvim-treesitter/playground" })
lvim.builtin.treesitter.playground.enable = true

-- ==== Treesitter: Text subjects ====
table.insert(lvim.plugins, { "nvim-treesitter/nvim-treesitter-textobjects" })
lvim.builtin.treesitter.textobjects = {
	swap = {
		enable = false,
		-- swap_next = textobj_swap_keymaps,
	},
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",

			["ac"] = "@class.outer",
			["ic"] = "@class.inner",

			["a,"] = "@parameter.outer",
			["i,"] = "@parameter.inner",

			["a/"] = "@comment",
			["i/"] = "@comment.inner",

			["ax"] = "@htmlattr.outer",
			["ix"] = "@htmlattr.inner",
		},
	},
}

-- ==== Treesitter: Context ====
table.insert(lvim.plugins, {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup()
	end,
})

-- ==== Text objects ====
vim.list_extend(lvim.plugins, {
	-- Foundation for custom textobjects
	{ "kana/vim-textobj-user" },
	-- CamelCase and underscore_case text objects (v)
	{ "Julian/vim-textobj-variable-segment" },
	-- Current line (al and il)
	{ "kana/vim-textobj-line" },
})

-- ==== Language-specific: Pandoc ====
vim.list_extend(lvim.plugins, {
	{
		"aspeddro/cmp-pandoc.nvim",
		config = function()
			require("cmp_pandoc").setup()
		end,
	},
	{ "jbyuki/nabla.nvim" },
})
table.insert(lvim.builtin.cmp.sources, { name = "cmp_pandoc" })

-- ==== Language-specific: zk ====
table.insert(lvim.plugins, {
	"mickael-menu/zk-nvim",
	ft = { "markdown" },
	config = function()
		require("zk").setup({
			-- can be "telescope", "fzf" or "select" (`vim.ui.select`)
			-- it's recommended to use "telescope" or "fzf"
			picker = "telescope",

			lsp = {
				-- `config` is passed to `vim.lsp.start_client(config)`
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
					-- on_attach = ...
					-- etc, see `:h vim.lsp.start_client()`
				},

				-- automatically attach buffers in a zk notebook that match the given filetypes
				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
			},
		})
	end,
})

-- ==== Language-specific: Dart/Flutter ====
table.insert(lvim.plugins, {
	"akinsho/flutter-tools.nvim",
	ft = { "dart" },
	config = function()
		require("flutter-tools").setup({
			ui = {
				notification_style = "plugin",
			},
			lsp = {
				on_attach = require("lvim.lsp").common_on_attach,
			},
			debugger = {
				enabled = true,
				run_via_dap = false,
			},
		})
	end,
})

table.insert(lvim.lsp.automatic_configuration.skipped_servers, "dartls")

-- ==== Language-specific: HTML ====
-- Enable emmet LSP
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(entry)
	return entry ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)
