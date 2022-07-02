local manager = require("lvim.lsp.manager")
local fix = require("h4s.volar-fix")

local M = {}

local enabled = false

function M.is_enabled()
	return enabled
end

local function kill_tsserver()
	local clients = vim.lsp.get_active_clients()
	for _, client in ipairs(clients) do
		if client.name == "tsserver" then
			vim.lsp.stop_client(client)
		end
	end
end

local function remove_client(server_name, ft)
	local autocmds = vim.api.nvim_get_autocmds({
		event = "FileType",
		pattern = ft,
	})

	for _, autocmd in ipairs(autocmds) do
		if autocmd.command:match(server_name) then
			vim.api.nvim_del_autocmd(autocmd.id)
		end
	end
end

local function client_is_configured(server_name, ft)
	ft = ft or vim.bo.filetype
	local active_autocmds = vim.split(vim.fn.execute("autocmd FileType " .. ft), "\n")
	for _, result in ipairs(active_autocmds) do
		if result:match(server_name) then
			return true
		end
	end
	return false
end

---Setup and start volar server
---@param takeover boolean|nil If true, enable takeover mode. Default to false.
local function start_volar(takeover)
	if takeover == nil then
		takeover = false
	end

	-- Install temp fix for volar code action
	fix.install()

	local cfg = {
		handlers = fix.handlers,
	}

	if takeover then
		cfg.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }
	end

	manager.setup("volar", cfg)
end

---Enable volar's takeover mode.
---This will stop existing tsserver clients and setup volar on ts/js filetypes
function M.enable()
	enabled = true
end

local has_setup = false

function M.setup()
	if has_setup then
		return
	end

	has_setup = true

	local id = -1

	id = vim.api.nvim_create_autocmd({ "VimEnter", "User ConfigFinished" }, {
		pattern = { "*.vue", "*.ts", "*.js", "*.tsx", "*.jsx" },
		callback = function()
			-- Make it call once only
			if id ~= -1 then
				vim.api.nvim_del_autocmd(id)
			end

			if M.is_enabled() then
				remove_client("volar", "vue")

				if client_is_configured("volar", "vue") then
					vim.notify("volar already setup")
				end

				kill_tsserver()
				start_volar(true)
			else
				manager.setup("tsserver")
				start_volar(false)
			end
		end,
	})
end

return M
