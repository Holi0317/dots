local handlers = require("vim.lsp.handlers")

local M = {}

local function fix_zero_version(workspace_edit)
	if workspace_edit and workspace_edit.documentChanges then
		for _, change in pairs(workspace_edit.documentChanges) do
			local text_document = change.textDocument
			if text_document then
				text_document.version = nil
			end
		end
	end
	return workspace_edit
end

local function on_textdocument_codeaction(err, actions, ctx)
	vim.notify(vim.inspect(actions))
	for _, action in ipairs(actions) do
		action.edit = fix_zero_version(action.edit or action.arguments[1])
		-- -- TODO: (steelsojka) Handle more than one edit?
		-- if action.command == "java.apply.workspaceEdit" then -- 'action' is Command in java format
		-- 	action.edit = fix_zero_version(action.edit or action.arguments[1])
		-- elseif type(action.command) == "table" and action.command.command == "java.apply.workspaceEdit" then -- 'action' is CodeAction in java format
		-- 	action.edit = fix_zero_version(action.edit or action.command.arguments[1])
		-- end
	end

	handlers[ctx.method](err, actions, ctx)
end

local function on_textdocument_rename(err, workspace_edit, ctx)
	handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

local function on_workspace_applyedit(err, workspace_edit, ctx)
	vim.notify(ctx.method)
	handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

M.handlers = {
	["textDocument/codeAction"] = on_textdocument_codeaction,
	["textDocument/rename"] = on_textdocument_rename,
	["workspace/applyEdit"] = on_workspace_applyedit,
}

-- Install temporary fix for volar code action.
M.install = function()
	vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
		local text_document = text_document_edit.textDocument
		local bufnr = vim.uri_to_bufnr(text_document.uri)
		if offset_encoding == nil then
			vim.notify_once("apply_text_document_edit must be called with valid offset encoding", vim.log.levels.WARN)
		end

		vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
	end
end

return M
