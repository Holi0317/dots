--- Disable leaky options when editing secret files
---
--- Heavily inspired by the redact_pass from `pass`
--- https://git.zx2c4.com/password-store/tree/contrib/vim/redact_pass.vim

local au = require("lvim.core.autocmds")

local M = {}

--- Get list of loaded buffer handles
--- @return number[]
local function loaded_bufs()
	local all_bufs = vim.api.nvim_list_bufs()
	local ret = {}

	for _, buf in ipairs(all_bufs) do
		if vim.api.nvim_buf_is_loaded(buf) then
			table.insert(ret, buf)
		end
	end

	return ret
end

--- Find buffer handler within loaded buffers with the given filename.
--- If there is no buffer with the given filename, `nil` will be returned
---
--- @param filename string Filename to be searched for
--- @return number|nil Buffer handler for the filename, nil if not found
local function find_buf(filename)
	local path = vim.fn.fnamemodify(filename, ":p")

	local bufs = loaded_bufs()
	for _, buf in ipairs(bufs) do
		local buf_filename = vim.api.nvim_buf_get_name(buf)
		if buf_filename == path then
			return buf
		end
	end

	return nil
end

--- Check if we should redact base on currently editing file
--- @return boolean
function M.should_redact()
	-- Must be editing one file only
	if vim.fn.argc() ~= 1 then
		return false
	end

	-- Get filename for editing
	local filename = vim.fn.argv(0)
	local buf = find_buf(filename)
	if buf == nil then
		return false
	end

	return true
end

--- Redact neovim
---
--- This does not check if redact function has run or not
function M.redact()
	vim.o.backup = false
	vim.o.writebackup = false
	vim.o.swapfile = false
	vim.o.shada = ""
	vim.o.undofile = false
	vim.o.clipboard = ""

	-- Stop all LSP
	vim.lsp.stop_client(vim.lsp.get_active_clients())

	-- Disable plugins that may leak
	au.disable_augroup("NvimLastplace")
end

-- Remember if we have redact once or not
local redacted = false

--- Run redact if we haven't run it before and we should redact.
function M.redact_once()
	if redacted then
		return
	end

	if not M.should_redact() then
		return
	end

	M.redact()

	redacted = true
	vim.notify("Redacted neovim succeed", vim.log.levels.INFO, {
		title = "Redact",
	})

	vim.defer_fn(M.redact, 100)
end

--- Setup autocommands for redact
function M.setup()
	lvim.autocommands.redact = {
		{ "VimEnter", "/dev/shm/*", ":lua require('h4s.redact').redact_once()" },
		{ "VimEnter", "secret", ":lua require('h4s.redact').redact_once()" },
	}
end

return M
