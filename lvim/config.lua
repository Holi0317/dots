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

-- ==== Keybindings: buffer navigation and actions ====
lvim.keys.normal_mode["]b"] = ":BufferNext<CR>"
lvim.keys.normal_mode["[b"] = ":BufferPrevious<CR>"
lvim.builtin.which_key.mappings["b"] = {
	name = "Buffers",

	j = { "<cmd>BufferPick<cr>", "Jump" },
	f = { "<cmd>Telescope buffers<cr>", "Find" },
	l = { "<cmd>Telescope buffers<cr>", "Find" },
	b = { "<cmd>b#<cr>", "Previous" },

	-- Wait what's difference between BufferDelete and BufferWipeout
	w = { "<cmd>BufferWipeout<cr>", "Wipeout/Delete current buffer" },
	d = { "<cmd>BufferDelete<cr>", "Delete current buffer" },

	o = {
		"<cmd>BufferCloseAllButCurrent<cr>",
		"Close all but current",
	},
	H = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left" },
	L = {
		"<cmd>BufferCloseBuffersRight<cr>",
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
		"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
		"Previous Diagnostic",
	},
}, { prefix = "[" })
deferwk.register({
	["i"] = {
		"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
		"Next Diagnostic",
	},
}, { prefix = "]" })

-- Note: This table will be mutated later in this file
-- Search for usage of `lsp_keybinds` to see where will mutate this table.
local lsp_keybinds = {
	name = "LSP",

	a = { "<cmd>lua require('lvim.core.telescope').code_actions()<cr>", "Code Action" },
	d = {
		"<cmd>Telescope lsp_document_diagnostics<cr>",
		"Document Diagnostics",
	},
	w = {
		"<cmd>Telescope lsp_workspace_diagnostics<cr>",
		"Workspace Diagnostics",
	},
	f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
	i = { "<cmd>LspInfo<cr>", "Info" },
	I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
	j = {
		"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
		"Next Diagnostic",
	},
	k = {
		"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
		"Prev Diagnostic",
	},
	l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
	p = {
		name = "Peek",
		d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
		t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
		i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
	},
	q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
	r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	S = {
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		"Workspace Symbols",
	},
}

deferwk.register(lsp_keybinds, { prefix = ";" })
lvim.builtin.which_key.mappings.l = lsp_keybinds

-- ==== Keybindings: Telescope projects ====
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

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

-- ==== Spelling ====
table.insert(lvim.plugins, { "f3fora/cmp-spell" })
table.insert(lvim.builtin.cmp.sources, { name = "spell" })

vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spelllang = { "en_us" }

-- ==== Sudo write ====
vim.cmd(":ca w!! lua require('h4s.sudo').sudo_write()")

-- ==== redact ====
-- TODO: Port this to lua and disable LSP on load
vim.cmd("source ~/.config/lvim/redact.vim")

-- ==== Telescope (Fuzzy searcher) ====
lvim.keys.normal_mode["<C-p>"] = ":Telescope find_files<cr>"

-- ==== Surround ====
table.insert(lvim.plugins, { "tpope/vim-surround" })

-- ==== Lightspeed ====
table.insert(lvim.plugins, { "ggandor/lightspeed.nvim" })

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
	{ "User", "GnuPG", "set noswapfile noundofile nobackup nowritebackup" },
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

-- ==== Formatters ====
-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "stylua" },
	{ exe = "prettier" },
})

-- ==== Linters ====

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({})

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

-- ==== Neorg ====
table.insert(lvim.plugins, {
	"nvim-neorg/neorg",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("neorg").setup({
			-- Tell Neorg what modules to load
			load = {
				["core.defaults"] = {}, -- Load all the default modules
				["core.norg.concealer"] = {}, -- Allows for use of icons
				["core.norg.dirman"] = { -- Manage your directories with Neorg
					config = {
						workspaces = {
							home = "~/neorg",
						},
					},
				},
				["core.norg.completion"] = {
					config = {
						engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
					},
				},
			},
		})
	end,
})

-- ==== Neorg: Treesitter ====
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}

-- ==== Neorg: cmp completion ====
table.insert(lvim.builtin.cmp.sources, { name = "neorg" })
