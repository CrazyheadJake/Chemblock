local util = require("util")

local starting_pack = "space-station-starter-pack"
local starting_planet = "nauvis"

local function starting_items()
  return
  {
    ["crusher"] = 4,
    ["asteroid-collector"] = 4,
    ["solar-panel"] = 4,
    ["small-electric-pole"] = 10
  }
end

-- Scatter space rocks across a platform's floor.
local SPACE_ROCK = "big-space-rock"
local SPACE_ROCK_COUNT = 10

local function seed_space_rocks(surface)
  local tiles = surface.find_tiles_filtered{name = "space-platform-foundation"}
  if #tiles == 0 then return end

  for _ = 1, SPACE_ROCK_COUNT do
    local tile = tiles[math.random(#tiles)]
    local position = surface.find_non_colliding_position(SPACE_ROCK, tile.position, 8, 0.5)
    if position then
      surface.create_entity{name = SPACE_ROCK, position = position, force = "neutral"}
    end
  end
end

local function get_or_create_starting_platform(force)
  if storage.platform and storage.platform.valid then
    return storage.platform
  end

  storage.platform = force.create_space_platform{
    name = "Chemblock Station",
    planet = starting_planet,
    starter_pack = starting_pack,
  }
  storage.platform.apply_starter_pack()
  seed_space_rocks(storage.platform.surface)

  return storage.platform
end

script.on_event(defines.events.on_player_created, function(event)
  local player = game.get_player(event.player_index)
  local platform = get_or_create_starting_platform(player.force)
  player.enter_space_platform(storage.platform)

  player.set_controller({type = defines.controllers.character, character = player.character})
  local exit_position = platform.surface.find_non_colliding_position("character", {0, 0}, 0, 0.25)
  player.teleport(exit_position, platform.surface)
  
  util.insert_safe(player, starting_items())
end)

script.on_event(defines.events.on_player_respawned, function(event)
  local player = game.get_player(event.player_index)
  local platform = get_or_create_starting_platform(player.force)
  game.print(player.force.get_spawn_position(platform.surface))
  player.enter_space_platform(storage.platform)

  player.set_controller({type = defines.controllers.character, character = player.character})
  local exit_position = platform.surface.find_non_colliding_position("character", {0, 0}, 0, 0.25)
  player.teleport(exit_position, platform.surface)
end)

script.on_nth_tick(30, function()
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered{name = "resource-asteroid"}) do
      if entity.force.name == "enemy" then
        entity.force = "neutral"
      end

      if entity.health == 0 then
        entity.die()
      end
    end
  end
end)

local SMELTING_TIME = 10
local SMELTABLE_ITEMS = {["iron-ore"] = "iron-plate", ["copper-ore"] = "copper-plate"}

script.on_nth_tick(60, function(event)
  print("checking")
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
      item.destroy()
      surface.spill_item_stack({
        position = position,
        stack = {name=result, count=1}
      })
      table.remove(storage.dropped_items, index)
      
    end
      ::continue::
  end
end)

script.on_event(defines.events.on_player_dropped_item, function(event)
  local item = event.entity
  if SMELTABLE_ITEMS[item.stack.name] == nil then
    return
  end
  storage.dropped_items = storage.dropped_items or {}
  table.insert(storage.dropped_items, {entity = item, end_tick = event.tick + 60 * SMELTING_TIME})
end)


script.on_init(function()
  game.forces.player.unlock_space_platforms()
  storage.dropped_items = {}

  remote.call("freeplay", "set_disable_crashsite", true)
  remote.call("freeplay", "set_skip_intro", true)
  remote.call("freeplay", "set_created_items", {})
  remote.call("freeplay", "set_respawn_items", {})
end)
