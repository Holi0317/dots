return {
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = true,
		cmd = { "Lspsaga" },
		config = function()
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
		end,
	},

	{
		"stevearc/aerial.nvim",
		opts = true,
		cmd = {
			"AerialToggle",
			"AerialOpen",
			"AerialOpenAll",
			"AerialClose",
			"AerialCloseAll",
			"AerialNext",
			"AerialPrev",
			"AerialGo",
			"AerialInfo",
			"AerialNavToggle",
			"AerialNavOpen",
			"AerialNavClose",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"j-hui/fidget.nvim",
		config = true,
	},
	{ "antoinemadec/FixCursorHold.nvim" },
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({
				max_width = function()
					local winwidth = vim.fn.winwidth(0)
					local target = math.floor(winwidth / 4)

					return math.min(math.max(target, 60), 120)
				end,
			})

			vim.notify = notify
		end,
	},

	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				enabled = true,

				-- When true, <Esc> will close the modal
				insert_only = false,
			},
			select = {
				-- Set to false to disable the vim.ui.select implementation
				enabled = true,
			},
		},
	},

	{
		"folke/trouble.nvim",
		opts = {
			auto_refresh = false,
			focus = true,
		},
	},

	{
		"gbprod/yanky.nvim",
		config = true,
	},

	{
		-- Indent line visual
		"lukas-reineke/indent-blankline.nvim",
		enabled = true,
		config = function()
			vim.opt.listchars = {
				--space = "⋅",
				-- eol = "↴",
				tab = "| ",
				-- tab = "|_>",
				trail = "•",
				-- extends = "❯",
				-- precedes = "❮",
				nbsp = "",
			}
			require("ibl").setup({})
		end,
	},

	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
		end,
	},

	{
		"folke/todo-comments.nvim",
		config = true,
	},
	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar" },
		config = function()
			require("grug-far").setup({
				-- shortcuts for the actions you see at the top of the buffer
				-- set to '' or false to unset. Mappings with no normal mode value will be removed from the help header
				-- you can specify either a string which is then used as the mapping for both normal and insert mode
				-- or you can specify a table of the form { [mode] = <lhs> } (ex: { i = '<C-enter>', n = '<localleader>gr'})
				-- it is recommended to use <localleader> though as that is more vim-ish
				-- see https://learnvimscriptthehardway.stevelosh.com/chapters/11.html#local-leader
				keymaps = {
					help = { n = "g?" },
					gotoLocation = { n = "<enter>" },
					pickHistoryEntry = { n = "<enter>" },
					openNextLocation = { n = "<down>" },
					openPrevLocation = { n = "<up>" },

					replace = { n = "\\r" },
					qflist = { n = "\\q" },
					syncLocations = { n = "\\s" },
					syncLine = { n = "\\l" },
					close = { n = "" },
					historyOpen = { n = "\\t" },
					historyAdd = { n = "\\a" },
					refresh = { n = "\\f" },
					openLocation = { n = "o" },
					abort = { n = "<C-c>" },
					toggleShowCommand = { n = "\\p" },
					swapEngine = { n = "\\e" },
					previewLocation = { n = "\\i" },
					swapReplacementInterpreter = { n = "\\x" },
					applyNext = { n = "<C-j>" },
					applyPrev = { n = "<C-k>" },
				},
			})
		end,
	},
}
