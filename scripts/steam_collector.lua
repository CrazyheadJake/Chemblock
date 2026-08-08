-- Pair each steam asteroid collector with its hidden generator + pole.
--
-- AsteroidCollectorPrototype only accepts an electric or void energy source, so
-- the collector itself can't drink steam. Instead a hidden generator sits at the
-- same position and converts steam to power, and a hidden pole (supply area 2,
-- max wire distance 0) joins the two into their own little network. Nothing
-- connects electrically without a pole covering it, which is why the pole exists.

local COLLECTOR = "steam-asteroid-collector"
local GENERATOR = "steam-asteroid-collector-generator"
local POLE = "steam-asteroid-collector-pole"

local function attach_companions(collector)
  local surface, position, force = collector.surface, collector.position, collector.force

  local generator = surface.create_entity{name = GENERATOR, position = position, force = force}
  local pole = surface.create_entity{name = POLE, position = position, force = force}

  -- destructible is a runtime attribute, not a prototype field, so it has to be
  -- set here rather than on the prototype.
  generator.destructible = false
  pole.destructible = false

  storage.steam_collectors = storage.steam_collectors or {}
  storage.steam_collectors[collector.unit_number] = {generator = generator, pole = pole}
end

local function detach_companions(unit_number)
  local companions = storage.steam_collectors and storage.steam_collectors[unit_number]
  if not companions then return end

  if companions.generator.valid then companions.generator.destroy() end
  if companions.pole.valid then companions.pole.destroy() end
  storage.steam_collectors[unit_number] = nil
end

local function on_built(event)
  if event.entity and event.entity.valid and event.entity.name == COLLECTOR then
    attach_companions(event.entity)
  end
end

local function on_removed(event)
  if event.entity and event.entity.valid and event.entity.name == COLLECTOR then
    detach_companions(event.entity.unit_number)
  end
end

-- on_space_platform_built_entity matters here: on a platform the hub does the
-- building, so the ordinary player/robot build events never fire.
register_event(defines.events.on_built_entity, on_built)
register_event(defines.events.on_robot_built_entity, on_built)
register_event(defines.events.on_space_platform_built_entity, on_built)

register_event(defines.events.on_player_mined_entity, on_removed)
register_event(defines.events.on_robot_mined_entity, on_removed)
register_event(defines.events.on_space_platform_mined_entity, on_removed)
register_event(defines.events.on_entity_died, on_removed)
