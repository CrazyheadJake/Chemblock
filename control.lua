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

script.on_init(function()
  game.forces.player.unlock_space_platforms()

  remote.call("freeplay", "set_disable_crashsite", true)
  remote.call("freeplay", "set_skip_intro", true)
  remote.call("freeplay", "set_created_items", {})
  remote.call("freeplay", "set_respawn_items", {})
end)
