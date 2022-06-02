local M = {}

---Create a lsp on_attach callback for blocking some lsp client's formatting capabilities.
---@param clients string[]
---@return function
function M.mk_block_formatter(clients)
	local version = vim.version()

	local function block_formatter(client, bufnr)
		for _, c in ipairs(clients) do
			if client.name == c then
				if version.minor >= 8 then
					-- TODO: Remove 0.7 support when 0.8 is released
					-- 0.8 and later
					client.resolved_capabilities.documentFormattingProvider = false
				else
					-- 0.7 and earlier
					client.resolved_capabilities.document_formatting = false
					client.resolved_capabilities.document_range_formatting = false
				end
			end
		end
	end

	return block_formatter
end

return M
