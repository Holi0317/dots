local mp = require("mp")
local utils = require("mp.utils")

local M = {}
M.__index = M

---@class M
---@field del_list string[]
---@field show_list_timer any
function M:create()
	local obj = {} -- our new object
	setmetatable(obj, M) -- make M handle lookup

	obj.del_list = {}
	obj.show_list_timer = mp.add_periodic_timer(1, function()
		obj:show_list()
	end)
	obj.show_list_timer:kill()

	return obj
end

---@param item string
---@return boolean
function M:contains_item(item)
	for k, v in pairs(self.del_list) do
		if v == item then
			mp.osd_message("undeleting current file")
			self.del_list[k] = nil
			return true
		end
	end

	mp.osd_message("deleting current file")
	return false
end

--- Mark currently playing file to delete
function M:mark_delete()
	local work_dir = mp.get_property_native("working-directory")
	local file_path = mp.get_property_native("path")
	local s = file_path:find(work_dir, 0, true)
	local final_path

	if s and s == 0 then
		final_path = file_path
	else
		final_path = utils.join_path(work_dir, file_path)
	end

	if not self:contains_item(final_path) then
		table.insert(self.del_list, final_path)
	end
end

function M:delete()
	for _, v in pairs(self.del_list) do
		print("deleting: " .. v)
		os.remove(v)
	end
end

function M:show_list()
	local del_string = "Delete Marks:\n"
	for _, v in pairs(self.del_list) do
		local dFile = v:gsub("/", "\\")
		del_string = del_string .. dFile:match("\\*([^\\]*)$") .. "; "
	end

	if del_string:find(";") then
		mp.osd_message(del_string)
		return del_string
	elseif self.show_list_timer then
		self.show_list_timer:kill()
	end
end

function M:list_marks()
	if self.show_list_timer:is_enabled() then
		self.show_list_timer:kill()
		mp.osd_message("", 0)
	else
		local delString = self:show_list()
		if delString and delString:find(";") then
			self.show_list_timer:resume()
			print(delString)
		else
			self.show_list_timer:kill()
		end
	end
end

function M:bind_keys()
	mp.add_key_binding("ctrl+DEL", "delete_file", function()
		self:mark_delete()
	end)
	mp.add_key_binding("META+BS", "delete_file", function()
		self:mark_delete()
	end) -- For MacOS

	mp.add_key_binding("alt+DEL", "list_marks", function()
		self:list_marks()
	end)

	mp.add_key_binding("ctrl+shift+DEL", "clear_list", function()
		mp.osd_message("Undelete all")
		self.del_list = {}
	end)
	mp.register_event("shutdown", function()
		self:delete()
	end)
end

local m = M:create()
m:bind_keys()
