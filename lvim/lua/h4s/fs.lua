local M = {}

function M.mkdir(path)
  if vim.fn.isdirectory(path) == 1 then
    return
  end

  vim.fn.mkdir(path, "p")
end

return M
