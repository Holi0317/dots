local M = {}

---Get current system with uname.
---
---IDK what will return other than MacOS/Linux (Windows, Plan9, BSD, etc)
---
---@return "Darwin"|"Linux"
function M.sysname()
	return vim.loop.os_uname().sysname
end

local _is_wsl = nil

local function is_wsl()
	if M.sysname() ~= "Linux" then
		return false
	end

	local version_file = io.open("/proc/version", "rb")
	if version_file ~= nil and string.find(version_file:read("*a"), "microsoft") then
		version_file:close()
		return true
	end
	return false
end

function M.is_wsl()
	if _is_wsl == nil then
		_is_wsl = is_wsl()
	end

	return _is_wsl
end

return M
