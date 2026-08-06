local util = require("util")

local nth_ticks = {}
function register_nth_tick(nth, func)
  nth_ticks[nth] = nth_ticks[nth] or {}
  table.insert(nth_ticks[nth], func)
end

local events = {}
function register_event(event, func)
  events[event] = events[event] or {}
  table.insert(events[event], func)
end

require("scripts.dropped_smelting")
require("scripts.platform")

for nth, funcs in pairs(nth_ticks) do
  script.on_nth_tick(nth, function(event)
    for _, func in ipairs(funcs) do
      func(event)
    end
  end)
end

for event, funcs in pairs(events) do
  script.on_event(event, function(e)
    for _, func in ipairs(funcs) do
      func(e)
    end
  end)
end

script.on_init(function()
  game.forces.player.unlock_space_platforms()
  storage.dropped_items = {}

  remote.call("freeplay", "set_disable_crashsite", true)
  remote.call("freeplay", "set_skip_intro", true)
  remote.call("freeplay", "set_created_items", {})
  remote.call("freeplay", "set_respawn_items", {})
end)
