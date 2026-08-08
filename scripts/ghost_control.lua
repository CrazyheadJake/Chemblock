-- Stop the space platform hub from auto-building ghosts.
--
-- The hub's construction speed isn't exposed anywhere: SpacePlatformHubPrototype
-- has no construction fields, there is no hidden construction-robot entity
-- backing it, and max_successful_attempts_per_tick_per_construction_queue only
-- caps how many queue entries are processed per tick, not how long one takes.
-- So instead of slowing the builder down, we take the work away from it: ghosts
-- are moved onto a force the hub doesn't serve, and just sit there.

local GHOST_FORCE = "chemblock-ghosts"
local GHOST_NAMES = {["entity-ghost"] = true, ["tile-ghost"] = true}

-- Created lazily rather than in on_init, so this works on saves that already
-- exist and doesn't need a hook in control.lua's single on_init.
local function get_ghost_force()
  local force = game.forces[GHOST_FORCE]
  if force then return force end

  force = game.create_force(GHOST_FORCE)
  -- Parked ghosts are inert scenery: make sure nothing treats them as hostile.
  for _, other in pairs(game.forces) do
    if other.name ~= GHOST_FORCE then
      force.set_friend(other, true)
      other.set_friend(force, true)
      force.set_cease_fire(other, true)
      other.set_cease_fire(force, true)
    end
  end
  return force
end

local function park_ghost(entity)
  if entity and entity.valid and GHOST_NAMES[entity.name] then
    entity.force = get_ghost_force()
  end
end

-- Immediate: the hub is fast, so a ghost has to change hands the tick it appears.
register_event(defines.events.on_built_entity, function(event)
  park_ghost(event.entity)
end)

register_event(defines.events.on_robot_built_entity, function(event)
  park_ghost(event.entity)
end)

-- Backstop for ghosts that appear by other routes (entities dying and leaving a
-- ghost behind, other mods, etc.) rather than being placed by a player.
register_nth_tick(60, function()
  for _, surface in pairs(game.surfaces) do
    for name in pairs(GHOST_NAMES) do
      for _, ghost in pairs(surface.find_entities_filtered{name = name, force = "player"}) do
        ghost.force = get_ghost_force()
      end
    end
  end
end)

-- A deconstruction planner only selects entities on the player's own force, so
-- it passes straight over parked ghosts. The selection event still hands us the
-- area and surface, so find them ourselves. Deconstructing a ghost removes it
-- outright -- there is nothing for a robot to haul away -- so destroy on the spot.
local function clear_parked_ghosts(event)
  if event.item ~= "deconstruction-planner" then return end

  local force = game.forces[GHOST_FORCE]
  if not force then return end

  for _, ghost in pairs(event.surface.find_entities_filtered{area = event.area, force = force}) do
    if GHOST_NAMES[ghost.name] then
      ghost.destroy()
    end
  end
end

register_event(defines.events.on_player_selected_area, clear_parked_ghosts)
register_event(defines.events.on_player_super_forced_selected_area, clear_parked_ghosts)

-- Hand a ghost back so it gets built normally. Nothing calls this yet -- it's
-- the hook for a future timed-revive step.
function unpark_ghost(entity)
  if entity and entity.valid and GHOST_NAMES[entity.name] then
    entity.force = "player"
  end
end
