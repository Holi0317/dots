local M = {}

---Get current system with uname.
---
---IDK what will return other than MacOS/Linux (Windows, Plan9, BSD, etc)
---
---@return "Darwin"|"Linux"
function M.sysname()
	return vim.loop.os_uname().sysname
end

function M.is_wsl()
	local version_file = io.open("/proc/version", "rb")
	if version_file ~= nil and string.find(version_file:read("*a"), "microsoft") then
		version_file:close()
		return true
	end
	return false
end

return M
