local M = {}

-- List of lsp that should not do formatting. Usually because formatting is done
-- via other tools managed via null-ls.
-- Use lspconfig name here (not binary/mason name).
local DISABLE_FORMAT = {
	"lua_ls",
	"jsonls",
	"html",
	"cssls",
}

---@type table<string,string[]>
local mappings = {
	["K"] = {
		function()
			local dap = require("dap")
			local widgets = require("dap.ui.widgets")

			if dap.session() ~= nil then
				widgets.hover()
			end

			vim.cmd("Lspsaga hover_doc")
		end,
		"Show hover",
	},
	["gd"] = { "<cmd>Trouble lsp_definitions<cr>", "Goto Definition" },
	["gr"] = { "<cmd>Trouble lsp_references<CR>", "Goto references" },
	["gI"] = { "<cmd>Trouble lsp_implementations<CR>", "Goto Implementation" },
	["gt"] = { "<cmd>Trouble lsp_type_definitions<cr>", "Goto type definition" },
	["gl"] = {
		"<cmd>Lspsaga show_line_diagnostics<CR>",
		"Show line diagnostics",
	},
}

local function setup_format(client, bufnr)
	if vim.tbl_contains(DISABLE_FORMAT, client.name) then
		return
	end

	require("lsp-format").on_attach(client, bufnr)
end

local function setup_document_highlight(client, bufnr)
	local status_ok, highlight_supported = pcall(function()
		return client:supports_method("textDocument/documentHighlight")
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
		callback = function()
			pcall(vim.lsp.buf.document_highlight)
		end,
	})
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = "lsp_document_highlight",
		buffer = bufnr,
		callback = function()
			pcall(vim.lsp.buf.clear_references)
		end,
	})
end

local function setup_codelens_refresh(client, bufnr)
	local status_ok, codelens_supported = pcall(function()
		return client:supports_method("textDocument/codeLens")
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
		callback = function()
			vim.lsp.codelens.refresh({ bufnr = bufnr })
		end,
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
	-- Disable semantic token highlighting for terraformls. Treesitter is doing
	-- a better job.
	if client.name == "terraformls" then
		client.server_capabilities.semanticTokensProvider = nil
	end

	setup_format(client, bufnr)
	setup_document_highlight(client, bufnr)
	setup_codelens_refresh(client, bufnr)
	setup_keymap(client, bufnr)
end

function M.setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

			M.on_attach(client, args.buf)
		end,
	})
end

return M
