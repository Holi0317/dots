local M = {}

function M.notify()
	local notify = require("notify")
	notify.setup({
		max_width = function()
			local winwidth = vim.fn.winwidth(0)
			local target = math.floor(winwidth / 4)

			return math.min(math.max(target, 60), 120)
		end,
	})

	vim.notify = notify
end

function M.dressing()
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
end

function M.trouble()
	require("trouble").setup()

	vim.keymap.set("n", "]t", function()
		require("trouble").next({ skip_groups = true, jump = true })
	end)

	vim.keymap.set("n", "[t", function()
		require("trouble").previous({ skip_groups = true, jump = true })
	end)
end

function M.yanky()
	require("yanky").setup({})
end

function M.indent()
	require("indent_blankline").setup({
		show_current_context = true,
		show_current_context_start = true,
	})
end

function M.comment()
	require("todo-comments").setup({})
end

function M.lightspeed()
	-- Setting up keymaps by ourselves to avoid conflict with which-key
	vim.g.lightspeed_no_default_keymaps = true

	vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>Lightspeed_s", { silent = true })
	vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>Lightspeed_S", { silent = true })

	vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>Lightspeed_f", { silent = true })
	vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>Lightspeed_F", { silent = true })
end

return M
