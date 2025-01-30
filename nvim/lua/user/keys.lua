local function dap(method)
	return function()
		require("dap")[method]()
	end
end

local M = {}

local function setup_vim_keys()
	-- ]i and [i for diagnostics
	vim.keymap.set("n", "]i", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
	vim.keymap.set("n", "[i", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous Diagnostic" })

	-- ]q and [q for quickfix
	vim.keymap.set("n", "]q", "<cmd>cn<cr>", { desc = "Next QuickFix" })
	vim.keymap.set("n", "[q", "<cmd>cp<cr>", { desc = "Previous QuickFix" })

	-- ]<space> and [<space> for insert space
	vim.keymap.set("n", "]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>", { silent = true })
	vim.keymap.set("n", "[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[", { silent = true })

	vim.keymap.set("n", "<C-c>", function()
		vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0
	end, {
		silent = true,
	})

	vim.keymap.set("n", "<C-z>", function()
		vim.wo.wrap = not vim.wo.wrap
	end, { silent = true })
end

local _lazygit = nil

function M.setup()
	local wk = require("which-key")

	setup_vim_keys()

	wk.add({ "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" })
	wk.add({
		"<leader>W",

		function()
			local lspformat = require("lsp-format")

			lspformat.disable({ args = "" })
			vim.cmd(":w")
			lspformat.enable({ args = "" })
		end,
		desc = "Save without format",
		icon = "",
	})
	wk.add({ "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file explorer" })

	-- Buffers
	wk.add({
		{ "<leader>b", group = "+Buffers", icon = "" },
		{ "<leader>bl", "<cmd>Telescope buffers<cr>", desc = "Find", icon = "" },
		{ "<leader>bd", "<cmd>BufDel<cr>", desc = "Delete current buffer", icon = "" },
		{
			"<leader>bo",
			"<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
			desc = "Close all but current",
		},
		{ "<leader>bH", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
		{
			"<leader>bL",
			"<cmd>BufferLineCloseRight<cr>",
			desc = "Close all to the right",
		},
	})

	-- Git
	wk.add({
		{ "<leader>g", group = "+Git", icon = "" },
		{
			"<leader>gj",
			function()
				require("gitsigns").nav_hunk("next")
			end,
			desc = "Next Hunk",
		},
		{
			"<leader>gk",
			function()
				require("gitsigns").nav_hunk("prev")
			end,
			desc = "Prev Hunk",
		},
		{
			"<leader>gl",
			function()
				require("gitsigns").blame_line()
			end,
			desc = "Blame",
		},
		{
			"<leader>gp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "Preview Hunk",
		},
		{
			"<leader>gr",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "Reset Hunk",
		},
		{
			"<leader>gR",
			function()
				require("gitsigns").reset_buffer()
			end,
			desc = "Reset Buffer",
		},
		{
			"<leader>gs",
			function()
				require("gitsigns").stage_hunk()
			end,
			desc = "Stage Hunk",
		},
		{
			"<leader>gu",
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			desc = "Undo Stage Hunk",
		},
		{ "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
		{
			"<leader>gC",
			"<cmd>Telescope git_bcommits<cr>",
			desc = "Checkout commit(for current file)",
		},
		{
			"<leader>gd",
			"<cmd>Gitsigns diffthis HEAD<cr>",
			desc = "Git Diff",
		},
		{
			"<leader>gg",
			function()
				if _lazygit == nil then
					local Terminal = require("toggleterm.terminal").Terminal
					_lazygit = Terminal:new({
						cmd = "lazygit",
						hidden = true,
						direction = "float",
					})
				end

				_lazygit:toggle()
			end,
			desc = "Launch LazyGit",
		},
	})

	-- Search (telescope)
	wk.add({
		{ "<leader>s", group = "+Search", icon = "" },
		{ "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
		{ "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
		{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Find highlight groups" },
		{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
		{ "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Text/Grep" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{
			"<leader>sp",
			"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
			desc = "Colorscheme with Preview",
		},
		{
			"<leader>sn",
			function()
				local telescope = require("telescope")
				telescope.load_extension("notify")
				require("telescope").extensions.notify.notify()
			end,
			desc = "Notifications",
		},
	})

	-- Search and replace (grug-far)
	wk.add({
		{ "<leader>f", "<cmd>GrugFar<cr>", desc = "+Search and replace", icon = "󰬲" },
	})

	-- Trouble (quick fix like)
	wk.add({
		{
			"]t",
			function()
				require("trouble").next({
					opts = {
						jump = true,
					},
				})
			end,
			desc = "Next trouble",
		},
		{
			"[t",
			function()
				require("trouble").prev({
					opts = {
						jump = true,
					},
				})
			end,
			desc = "Next trouble",
		},

		{ "<leader>t", group = "+Trouble", icon = "" },
		{ "<leader>tr", "<cmd>Trouble lsp_references<cr>", desc = "References" },
		{ "<leader>tf", "<cmd>Trouble lsp_definitions<cr>", desc = "Definitions" },
		{ "<leader>td", "<cmd>Trouble lsp_document_diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>tq", "<cmd>Trouble quickfix<cr>", desc = "QuickFix" },
		{ "<leader>tl", "<cmd>Trouble loclist<cr>", desc = "LocationList" },
		{ "<leader>tw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>tt", "<cmd>TodoTrouble<cr>", desc = "Todo" },
	})

	-- Debugging
	wk.add({
		{ "<leader>d", group = "+Debugging", icon = "" },
		{
			"<leader>dd",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle debug view",
			icon = "󰏌",
		},

		{ "<leader>ds", group = "+Steps", icon = "󰓍" },
		{ "<leader>dsi", dap("step_into"), desc = "into" },
		{ "<leader>dso", dap("step_over"), desc = "over" },
		{ "<leader>dsn", dap("step_over"), desc = "over" },
		{ "<leader>dsO", dap("step_out"), desc = "out" },
		{ "<leader>dsb", dap("step_back"), desc = "back" },

		{ "<leader>dv", group = "+Session", icon = "󰆘" },
		{ "<leader>dvs", dap("continue"), desc = "Start" },
		{ "<leader>dvd", dap("disconnect"), desc = "Disconnect" },
		{ "<leader>dvq", dap("close"), desc = "Stop/Quit" },
		{ "<leader>dvi", dap("session"), desc = "Get session info" },

		{ "<leader>db", dap("toggle_breakpoint"), desc = "Toggle Breakpoint" },
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
		{ "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
	})

	-- All the lsp goodies
	wk.add({
		{ ";", group = "LSP" },
		{ ";a", "<cmd>Lspsaga code_action<CR>", desc = "Code Action" },
		{ ";d", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
		{
			";D",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics",
		},
		{
			";f",
			"<cmd>Format<cr>",
			desc = "Format",
		},
		{ ";i", "<cmd>LspInfo<cr>", desc = "Info" },
		{ ";I", "<cmd>Mason<cr>", desc = "Installer Info" },
		{
			";j",
			function()
				vim.diagnostic.goto_next({ float = true })
			end,
			desc = "Next Diagnostic",
		},
		{
			";k",
			function()
				vim.diagnostic.goto_prev({ float = true })
			end,
			desc = "Prev Diagnostic",
		},
		{
			";l",
			function()
				vim.lsp.codelens.run()
			end,
			desc = "CodeLens Action",
		},
		{
			";r",
			"<cmd>Lspsaga rename<CR>",
			desc = "Rename",
		},
		{
			";R",
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

					vim.lsp.util.rename(name, input, {})

					local notify = require("user.lsp.notify")
					notify.didRenameFile(name, input)
				end)
			end,
			desc = "Rename file",
		},
		{
			";s",
			"<cmd>Lspsaga lsp_finder<CR>",
			desc = "Workspace Symbols",
		},
		{
			";p",
			"<cmd>Lspsaga peek_definition<CR>",
			desc = "Peak definition",
		},
		{
			";o",
			"<cmd>AerialToggle!<CR>",
			desc = "Show outline",
		},
	})
end

return M
