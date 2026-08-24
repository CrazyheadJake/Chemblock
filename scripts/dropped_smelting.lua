---@type Storage
storage = storage --[[@as Storage]]

local SMELTING_TIME = 10
local SMELTABLE_ITEMS = { ["iron-ore"] = "iron-plate", ["copper-ore"] = "copper-plate" }

register_nth_tick(60, function(event)
  local dropped_items = storage.dropped_items or {}
  for index, data in ipairs(dropped_items) do
    if event.tick >= data.end_tick then
      local item = data.entity
      if not item.valid then
        table.remove(storage.dropped_items, index)
        goto continue
      end
      local result = SMELTABLE_ITEMS[item.stack.name]
      local surface = item.surface
      local position = item.position
      local force = data.force
      item.destroy()
      surface.spill_item_stack({
        position = position,
        stack = { name = result, count = 1 }
      })
      -- Make the item appear to be "crafted" for trigger techs
      if force and force.valid then
        force.get_item_production_statistics(surface).on_flow(result, 1)
      end
      table.remove(storage.dropped_items, index)
    end
    ::continue::
  end
end)

register_event(defines.events.on_player_dropped_item, function(event)
  local item = event.entity
  if SMELTABLE_ITEMS[item.stack.name] == nil then
    return
  end
  local player = game.get_player(event.player_index)
  storage.dropped_items = storage.dropped_items or {}
  table.insert(storage.dropped_items, {
    entity = item,
    end_tick = event.tick + 60 * SMELTING_TIME,
    force = player and player.force or nil,
  })
end)
