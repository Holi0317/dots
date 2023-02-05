local M = {
	mappings = {
		["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		W = {
			function()
				-- FIXME: Find the autocmd for save
				local autocmds = require("lvim.core.autocmds")

				autocmds.disable_format_on_save()
				vim.schedule(function()
					vim.cmd(":w")
					autocmds.enable_format_on_save()
				end)
			end,
			"Save without format",
		},
		b = {
			name = "Buffers",
			f = { "<cmd>Telescope buffers<cr>", "Find" },
			d = { "<cmd>BufDel<cr>", "Delete current buffer" },
			o = {
				"<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
				"Close all but current",
			},
			H = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
			L = {
				"<cmd>BufferLineCloseRight<cr>",
				"Close all to the right",
			},
		},
		g = {
			name = "Git",
			j = {
				function()
					require("gitsigns").next_hunk()
				end,
				"Next Hunk",
			},
			k = {
				function()
					require("gitsigns").prev_hunk()
				end,
				"Prev Hunk",
			},
			l = {
				function()
					require("gitsigns").blame_line()
				end,
				"Blame",
			},
			p = {
				function()
					require("gitsigns").preview_hunk()
				end,
				"Preview Hunk",
			},
			r = {
				function()
					require("gitsigns").reset_hunk()
				end,
				"Reset Hunk",
			},
			R = {
				function()
					require("gitsigns").reset_buffer()
				end,
				"Reset Buffer",
			},
			s = {
				function()
					require("gitsigns").stage_hunk()
				end,
				"Stage Hunk",
			},
			u = {
				function()
					require("gitsigns").undo_stage_hunk()
				end,
				"Undo Stage Hunk",
			},
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
			C = {
				"<cmd>Telescope git_bcommits<cr>",
				"Checkout commit(for current file)",
			},
			d = {
				"<cmd>Gitsigns diffthis HEAD<cr>",
				"Git Diff",
			},
		},
		s = {
			name = "Search",
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			g = { "<cmd>Telescope live_grep<cr>", "Text" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
			p = {
				"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
				"Colorscheme with Preview",
			},
			n = {
				function()
					local telescope = require("telescope")
					telescope.load_extension("notify")
					require("telescope").extensions.notify.notify()
				end,
				"Notifications",
			},
		},
		t = {
			name = "+Trouble",
			r = { "<cmd>Trouble lsp_references<cr>", "References" },
			f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
			d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
			q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
			l = { "<cmd>Trouble loclist<cr>", "LocationList" },
			w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
			t = { "<cmd>TodoTrouble<cr>", "Todo" },
		},
	},
	lsp_mappings = {
		name = "LSP",

		a = {
			vim.lsp.buf.code_action,
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
		I = { "<cmd>Mason<cr>", "Installer Info" },
		j = {
			function()
				vim.diagnostic.goto_next({ float = true })
			end,
			"Next Diagnostic",
		},
		k = {
			function()
				vim.diagnostic.goto_prev({ float = true })
			end,
			"Prev Diagnostic",
		},
		l = {
			function()
				vim.lsp.codelens.run()
			end,
			"CodeLens Action",
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
	},
}

local function setup_vim_keys()
	vim.keymap.set('n', ']i', function()
		vim.diagnostic.goto_next({ float = true })
	end, { desc = "Next Diagnostic" })
	vim.keymap.set('n', '[i', function()
		vim.diagnostic.goto_prev({ float = true })
	end, { desc = "Previous Diagnostic" })
end

function M.setup()
	local wk = require("which-key")

	setup_vim_keys()

	wk.register(M.mappings, {
		prefix = "<leader>",
	})

	wk.register(M.lsp_mappings, {
		prefix = ";",
	})
end

return M
