local M = {}

-- TODO: Broadcast this client can notify these event
-- TODO: Check if server can accept these notification

---Notify LSP that we have created a file
---@param fname string Path to the file
function M.didCreateFile(fname)
	for _, client in ipairs(vim.lsp.get_clients()) do
		client.notify("workspace/didCreateFiles", {
			files = {
				{
					uri = "file://" .. fname,
				},
			},
		})
	end
end

---Notify LSP that we have renamed a file
---@param oldname string Path to the old file
---@param newname string Path to the new file
function M.didRenameFile(oldname, newname)
	for _, client in ipairs(vim.lsp.get_clients()) do
		client.notify("workspace/didRenameFiles", {
			files = {
				{
					oldUri = "file://" .. oldname,
					newUri = "file://" .. newname,
				},
			},
		})
	end
end

return M
