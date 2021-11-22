local M = {}

--- Add an empty line above current cursor
function M.addabove()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)

  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  if not vim.api.nvim_buf_get_option(buf, "modifiable") then
    -- Buffer is not modifiable. Do not attempt insert line
    return
  end

  local line = vim.api.nvim_get_current_line()

end

--- Add an empty line below current cursor
function M.addbelow()
end

return M
