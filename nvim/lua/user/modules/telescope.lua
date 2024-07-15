return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "descending",
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.75,
						preview_cutoff = 120,
						horizontal = {
							preview_width = function(_, cols, _)
								if cols < 120 then
									return math.floor(cols * 0.5)
								end
								return math.floor(cols * 0.6)
							end,
							mirror = false,
						},
						vertical = { mirror = false },
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
					mappings = {
						i = {
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-c>"] = actions.close,
							["<C-j>"] = actions.cycle_history_next,
							["<C-k>"] = actions.cycle_history_prev,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<CR>"] = actions.select_default,
							["<C-u>"] = function()
								vim.fn.setline(".", "")
							end,
						},
						n = {
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
					},
					file_ignore_patterns = {},
					path_display = { shorten = 5 },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				},
				pickers = {
					find_files = {
						find_command = { "fd", "--type=file", "--hidden", "-E", ".git" },
					},
				},
			})

			local builtin = require("telescope.builtin")

			vim.api.nvim_set_keymap("n", "<C-p>", "", {
				noremap = true,
				silent = true,
				callback = builtin.find_files,
			})
		end,
	},
}
