--- Deferred which-key registration for LunarVim
local M = {}

local mappings = {}
local up_config_done = lvim.builtin.which_key.on_config_done

local function on_config_done(wk)
  if up_config_done then
    up_config_done(wk)
  end

  for _, value in ipairs(mappings) do
    local mapping, opt = unpack(value)
    wk.register(mapping, opt)
  end
end

lvim.builtin.which_key.on_config_done = on_config_done

function M.register(mapping, opt)
  table.insert(mappings, {mapping, opt})
end

return M
