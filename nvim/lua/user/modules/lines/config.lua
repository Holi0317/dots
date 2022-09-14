local M = {}

function M.lualine()
	local window_width_limit = 70

	local conditions = {
		hide_in_width = function()
			return vim.fn.winwidth(0) > window_width_limit
		end,
	}

	local components = {
		mode = {
			"mode",
			fmt = function()
				return " "
			end,
			padding = 0,
		},
		branch = {
			"b:gitsigns_head",
			icon = " ",
			color = {
				gui = "bold",
			},
			cond = conditions.hide_in_width,
		},
		diff = {
			"diff",
			source = function()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end,
			diff_color = {
				added = {
					fg = "#98be65",
				},
				modified = {
					fg = "#ECBE7B",
				},
				removed = {
					fg = "#ec5f67",
				},
			},
			symbols = {
				added = "  ",
				modified = " ",
				removed = " ",
			},
		},
		filename = { "filename", path = 1 },
		filetype = {
			"filetype",
			cond = conditions.hide_in_width,
			icon_only = true,
		},
		diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			cond = conditions.hide_in_width,
		},
		lsp = {
			function(msg)
				msg = msg or "LS Inactive"
				local buf_clients = vim.lsp.buf_get_clients()
				if next(buf_clients) == nil then
					-- TODO: clean up this if statement
					if type(msg) == "boolean" or #msg == 0 then
						return "LS Inactive"
					end
					return msg
				end
				local buf_ft = vim.bo.filetype
				local buf_client_names = {}

				-- add client
				for _, client in pairs(buf_clients) do
					if client.name ~= "null-ls" then
						table.insert(buf_client_names, client.name)
					end
				end

				local s = require("null-ls.sources")
				local available_sources = s.get_available(buf_ft)
				for _, source in ipairs(available_sources) do
					table.insert(buf_client_names, source.name)
				end

				local unique_client_names = vim.fn.uniq(buf_client_names)
				return "[" .. table.concat(unique_client_names, ", ") .. "]"
			end,
			color = { gui = "bold" },
			cond = conditions.hide_in_width,
		},
		treesitter = {
			function()
				local b = vim.api.nvim_get_current_buf()
				if next(vim.treesitter.highlighter.active[b]) then
					return ""
				end
				return ""
			end,
			color = { fg = "#98be65" },
			cond = conditions.hide_in_width,
		},
		location = {
			"location",
			cond = conditions.hide_in_width,
			color = {},
		},
		progress = {
			"progress",
			cond = conditions.hide_in_width,
			color = {},
		},
		scrollbar = {
			function()
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")
				local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end,
			padding = { left = 0, right = 0 },
			color = { fg = "#ECBE7B", bg = "#202328" },
			cond = nil,
		},
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "gruvbox_dark",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "alpha", "NvimTree", "Outline" },
				winbar = { "alpha", "NvimTree", "Outline" },
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = {
				components.mode,
			},
			lualine_b = {
				components.branch,
				components.filename,
			},
			lualine_c = {
				components.diff,
			},
			lualine_x = {
				components.diagnostics,
				components.lsp,
				components.treesitter,
				components.location,
				components.filetype,
			},
			lualine_y = {},
			lualine_z = {
				components.scrollbar,
			},
		},
		inactive_sections = {
			lualine_a = {
				components.filename,
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {
			"nvim-tree",
		},
	})
end

function M.bufferline()
	require("bufferline").setup({
		options = {
			indicator = {
				icon = "▎",
			},
			buffer_close_icon = "",
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
				-- remove extension from markdown files for example
				if buf.name:match("%.md") then
					return vim.fn.fnamemodify(buf.name, ":t:r")
				end
			end,
			diagnostics = "nvim_lsp",
			separator_style = "thin",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					separator = true,
				},
			},
		},

		highlights = {
			background = {
				italic = true,
			},
			buffer_selected = {
				bold = true,
			},
		},
	})

	vim.api.nvim_set_keymap("n", "]b", ":BufferLineCycleNext<CR>", {
		noremap = true,
		silent = true,
	})

	vim.api.nvim_set_keymap("n", "[b", ":BufferLineCyclePrev<CR>", {
		noremap = true,
		silent = true,
	})
end

return M
