function format(time)
  return os.date('!%X', time)
end

function on_seek()
  local time_pos = mp.get_property_number('time-pos')
  local duration = mp.get_property_number('duration', 0)
  if time_pos < 0 then
    time_pos = 0
  end
  mp.commandv('show-text', format(time_pos) .. '/' .. format(duration))
end

mp.register_event('seek', on_seek)
