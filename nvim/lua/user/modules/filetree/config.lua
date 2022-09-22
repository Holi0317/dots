local M = {}

function M.nvimtree()
	require("nvim-tree").setup({
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		disable_netrw = true,
		hijack_netrw = true,
		open_on_setup = false,
		open_on_setup_file = false,
		sort_by = "name",
		ignore_buffer_on_setup = false,
		ignore_ft_on_setup = {
			"startify",
			"dashboard",
			"alpha",
		},
		auto_reload_on_write = true,
		hijack_unnamed_buffer_when_opening = false,
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		open_on_tab = false,
		hijack_cursor = false,
		update_cwd = false,
		diagnostics = {
			enable = true,
			show_on_dirs = false,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			update_root = true,
			ignore_list = {},
		},
		system_open = {
			cmd = nil,
			args = {},
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 200,
		},
		view = {
			width = 50,
			hide_root_folder = false,
			side = "left",
			preserve_window_proportions = false,
			mappings = {
				custom_only = false,
				list = {},
			},
			number = false,
			relativenumber = false,
			signcolumn = "yes",
		},
		renderer = {
			indent_markers = {
				enable = false,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
			icons = {
				webdev_colors = true,
				show = {
					git = true,
					folder = true,
					file = true,
					folder_arrow = true,
				},
				glyphs = {
					default = "",
					symlink = "",
					git = {
						unstaged = "",
						staged = "S",
						unmerged = "",
						renamed = "➜",
						deleted = "",
						untracked = "U",
						ignored = "◌",
					},
					folder = {
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
					},
				},
			},
			highlight_git = true,
			root_folder_modifier = ":t",
		},
		filters = {
			dotfiles = false,
			custom = { "node_modules", "\\.cache" },
			exclude = {},
		},
		trash = {
			cmd = "trash",
			require_confirm = true,
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				diagnostics = false,
				git = false,
				profile = false,
			},
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			open_file = {
				quit_on_open = false,
				resize_window = false,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
		},
	})

	local api = require("nvim-tree.api")
	local Event = api.events.Event
	-- api.events.subscribe(Event.NodeRenamed, function(data)
	-- 	print("Node renamed from " .. data.old_name .. " to " .. data.new_name)
	-- end)

	api.events.subscribe(Event.FileCreated, function(data)
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			client.notify("workspace/didCreateFiles", {
				files = {
					uri = "file://" .. data.fname,
				},
			})
		end
	end)
end

return M
