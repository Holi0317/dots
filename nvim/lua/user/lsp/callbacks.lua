local M = {}

---@type table<string,string[]>
local mappings = {
	["K"] = { vim.lsp.buf.hover, "Show hover" },
	["gd"] = { "<cmd>Trouble lsp_definitions<cr>", "Goto Definition" },
	["gr"] = { "<cmd>Trouble lsp_references<CR>", "Goto references" },
	["gI"] = { "<cmd>Trouble lsp_implementations<CR>", "Goto Implementation" },
	["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
	["gt"] = { "<cmd>Trouble lsp_type_definitions<cr>", "Goto type definition" },
	["gp"] = {
		function()
			require("lvim.lsp.peek").Peek("definition")
		end,
		"Peek definition",
	},
	["gl"] = {
		"<cmd>Lspsaga show_line_diagnostics<CR>",
		"Show line diagnostics",
	},
}

local function setup_document_highlight(client, bufnr)
	local status_ok, highlight_supported = pcall(function()
		return client.supports_method("textDocument/documentHighlight")
	end)
	if not status_ok or not highlight_supported then
		return
	end
	local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
		group = "lsp_document_highlight",
	})
	if not augroup_exist then
		vim.api.nvim_create_augroup("lsp_document_highlight", {})
	end
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = "lsp_document_highlight",
		buffer = bufnr,
		callback = vim.lsp.buf.document_highlight,
	})
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = "lsp_document_highlight",
		buffer = bufnr,
		callback = vim.lsp.buf.clear_references,
	})
end

local function setup_codelens_refresh(client, bufnr)
	local status_ok, codelens_supported = pcall(function()
		return client.supports_method("textDocument/codeLens")
	end)
	if not status_ok or not codelens_supported then
		return
	end
	local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
		group = "lsp_code_lens_refresh",
	})
	if not augroup_exist then
		vim.api.nvim_create_augroup("lsp_code_lens_refresh", {})
	end
	vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
		group = "lsp_code_lens_refresh",
		buffer = bufnr,
		callback = vim.lsp.codelens.refresh,
	})
end

local function setup_keymap(client, bufnr)
	for key, mapping in pairs(mappings) do
		local action = mapping[1]
		local desc = mapping[2]

		local opts = { buffer = bufnr, desc = desc, noremap = true, silent = true }

		vim.keymap.set("n", key, action, opts)
	end
end

function M.on_attach(client, bufnr)
	setup_document_highlight(client, bufnr)
	setup_codelens_refresh(client, bufnr)
	setup_keymap(client, bufnr)
end

function M.on_init() end

function M.on_exit() end

return M
