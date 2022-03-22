local deferwk = require("h4s.deferwk")

-- Additional plugins
table.insert(lvim.plugins, { "tpope/vim-repeat" })

-- ==== general ====
-- Aka I have no idea where to put these options
lvim.log.level = "warn"
lvim.format_on_save = true

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
	d = { "<cmd>bdelete<cr>", "Delete current buffer" },

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
			require("lvim.core.telescope").code_actions()
		end,
		"Code Action",
	},
	d = {
		"<cmd>Telescope lsp_document_diagnostics<cr>",
		"Document Diagnostics",
	},
	w = {
		"<cmd>Telescope lsp_workspace_diagnostics<cr>",
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
	S = {
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		"Workspace Symbols",
	},
}

deferwk.register(lsp_keybinds, { prefix = ";" })
lvim.builtin.which_key.mappings.l = lsp_keybinds

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

-- ==== Save and format on save ====
lvim.builtin.which_key.mappings["W"] = {
	function()
		local autocmds = require("lvim.core.autocmds")

		if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
			-- Format on save disabled
			vim.cmd(":w<CR>")
		else
			-- Format on save enabled
			autocmds.toggle_format_on_save()
			vim.schedule(function()
				vim.cmd(":w")
				autocmds.toggle_format_on_save()
			end)
		end
	end,
	"Save without format",
}

-- ==== Spelling ====
table.insert(lvim.plugins, { "f3fora/cmp-spell" })
table.insert(lvim.builtin.cmp.sources, { name = "spell" })

-- ==== Emoji ====
table.insert(lvim.plugins, { "hrsh7th/cmp-emoji" })

vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spelllang = { "en_us" }

-- ==== Notification ====
table.insert(lvim.plugins, {
	"rcarriga/nvim-notify",
	as = "notify", -- Somehow packer need this to have other name or it will refuse to install
	config = function()
		local notify = require("notify")
		notify.setup()
		vim.notify = notify
	end,
})

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
	components.treesitter,
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
	cmd = "TroubleToggle",
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

-- ==== DAP ====
lvim.builtin.dap.active = true
require("dap.ext.vscode").load_launchjs()
table.insert(lvim.plugins, {
	"leoluz/nvim-dap-go",
	opt = true,
	ft = { "go" },
	config = function()
		require("dap-go").setup()
	end,
})

-- ==== Formatters ====
-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "stylua" },
	{ exe = "prettier" },
	{ exe = "gofmt" },
	{ exe = "goimports" },
	{ exe = "eslint" },
})

-- ==== Linters ====

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "golangci-lint" },
	{ exe = "eslint" },
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

-- ==== Treesitter: Auto close HTML/XML tag
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
	-- move = textobj_move_keymaps,
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",

			["ac"] = "@class.outer",
			["ic"] = "@class.inner",

			["i,"] = "@parameter.inner",
			["a,"] = "@parameter.outer",

			["a/"] = "@comment.outer",
			["/"] = "@comment.outer",
		},
	},
}

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

-- ==== Language-specific: wgsl ====
vim.cmd([[au BufRead,BufNewFile *.wgsl	set filetype=wgsl]])

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.wgsl = {
	install_info = {
		url = "https://github.com/szebniok/tree-sitter-wgsl",
		files = { "src/parser.c" },
	},
}
