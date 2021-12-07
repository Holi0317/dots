local M = {}

--- Force remap given key to new operation in given buffer.
---
--- This is done by doing the actual remap after 100 ms and explicitly delete any previous
--- binding occupying the target keys.
---
--- The function signature is identical to `vim.api.nvim_buf_set_keymap`.
function M.force_buf_remap(buffer, mode, lhs, rhs, opts)
	local opts_ = opts or {}

	vim.defer_fn(function()
		pcall(function()
			vim.api.nvim_buf_del_keymap(buffer, mode, lhs)
		end)

		vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts_)
	end, 100)
end

return M
