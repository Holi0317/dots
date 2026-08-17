local M = {}

local DENO_CONFIG_MARKERS = { "deno.json", "deno.jsonc" }
local PROJECT_MARKERS = {
	{ "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" },
	{ ".git" },
}

---@param bufnr number
---@return string|nil
function M.root(bufnr)
	local deno_root = vim.fs.root(bufnr, DENO_CONFIG_MARKERS)
	local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
	local project_root = vim.fs.root(bufnr, PROJECT_MARKERS)

	if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
		return deno_lock_root
	end
	if deno_root and (not project_root or #deno_root >= #project_root) then
		return deno_root
	end

	return nil
end

---@param bufnr number
---@return boolean
function M.is_workspace(bufnr)
	return M.root(bufnr) ~= nil
end

return M
