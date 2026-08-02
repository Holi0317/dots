local M = {}

local function mise_where(tool)
	if vim.fn.executable("mise") == 0 then return nil end
	local result = vim.system({ "mise", "where", tool }, { text = true }):wait()
	if result.code ~= 0 then return nil end
	local path = (result.stdout:gsub("%s+$", ""))
	return path ~= "" and path or nil
end

---Find a module directory under a mise-managed install.
---
---Mason installs lived at `~/.local/share/nvim/mason/packages/<tool>/...`
---with a flat `node_modules/`. Mise with pnpm uses a content-addressable
---virtual store where the layout is `<install>/<store>/<hash>/node_modules/`
---and both `<store>` (e.g. `v11`) and `<hash>` are unpredictable.
---
---Uses a recursive `vim.fn.glob` with `wildignore` cleared because:
---  * `vim.fs.find` doesn't follow symlinks — pnpm's `node_modules/<name>/`
---    entries are symlinks into pnpm's global store, so they get filtered
---    out by `type = "directory"`.
---  * The default `wildignore` excludes `**/node_modules/**`.
---
---@param tool string mise tool spec, e.g. "npm:@vue/language-server"
---@param module_name string package subpath, e.g. "@vue/typescript-plugin"
---@return string|nil absolute path, or nil if not found
function M.find_module(tool, module_name)
	local install = mise_where(tool)
	if not install then return nil end
	local pattern = install .. "/**/node_modules/" .. module_name
	local old = vim.o.wildignore
	vim.o.wildignore = ""
	local results = vim.fn.glob(pattern, false, true)
	vim.o.wildignore = old
	return results[1]
end

return M
