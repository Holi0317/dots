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
		config = {
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
		keymaps = {
			{
				"]t",
				function()
					require("trouble").next({ skip_groups = true, jump = true })
				end,
			},
			{
				"[t",
				function()
					require("trouble").previous({ skip_groups = true, jump = true })
				end,
			},
		},
		config = true,
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
		"ggandor/lightspeed.nvim",
		config = function()
			vim.g.lightspeed_no_default_keymaps = true

			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>Lightspeed_s", { silent = true })
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>Lightspeed_S", { silent = true })

			vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>Lightspeed_f", { silent = true })
			vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>Lightspeed_F", { silent = true })
		end,
	},

	{
		"folke/todo-comments.nvim",
		config = true,
	},
}
