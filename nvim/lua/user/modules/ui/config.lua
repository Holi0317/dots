local M = {}

function M.notify()
	local notify = require("notify")
	local keys = require("user.keys")
	local telescope = require("telescope")

	vim.notify = notify

	-- TODO: Enable notify search binding
	--keys.mappings.s.n = {
	--	function()
	--		telescope.load_extension("notify")
	--		telescope.extensions.notify.notify()
	--	end,
	--	"Notifications",
	--}
end

return M
