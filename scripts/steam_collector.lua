-- Make the steam asteroid collector actually run on steam.
--
-- AsteroidCollectorPrototype only accepts an electric or void energy source, and
-- has no fluid_box at all. It uses void so it never touches the electric system
-- -- nothing to connect to, and no electricity line in its tooltip -- and a
-- hidden storage tank at the same position holds the steam the player pipes in.
-- This drains that tank and switches the collector off when it runs dry.
--
-- Note `active` is read-only in 2.x; disabled_by_script is the writable path.

local COLLECTOR = "steam-asteroid-collector"
local TANK = "steam-asteroid-collector-tank"

-- Steam is charged per chunk actually collected rather than per second of
-- uptime, so a collector with nothing in range costs nothing. At 20kJ per unit
-- of steam, this makes each chunk cost 80kJ.
local STEAM_PER_CHUNK = 4
-- Every tick: the output count has to be sampled finely, or a chunk that an
-- inserter pulls straight back out goes unnoticed.
local INTERVAL = 1

local function attach_tank(collector)
  local tank = collector.surface.create_entity{
    name = TANK,
    position = collector.position,
    force = collector.force,
    -- Without this the tank always faces north, so a rotated collector ends up
    -- with its steam inlet on the wrong side.
    direction = collector.direction,
  }
  -- destructible is a runtime attribute, not a prototype field.
  tank.destructible = false

  storage.steam_collectors = storage.steam_collectors or {}
  storage.steam_collectors[collector.unit_number] = {collector = collector, tank = tank}
end

local function detach_tank(unit_number)
  local pair = storage.steam_collectors and storage.steam_collectors[unit_number]
  if not pair then return end

  if pair.tank.valid then pair.tank.destroy() end
  storage.steam_collectors[unit_number] = nil
end

local function on_built(event)
  if event.entity and event.entity.valid and event.entity.name == COLLECTOR then
    event.entity.disabled_by_script = true 
    attach_tank(event.entity)
  end
end

local function on_removed(event)
  if event.entity and event.entity.valid and event.entity.name == COLLECTOR then
    detach_tank(event.entity.unit_number)
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

-- Items a player puts in by hand land in the same output inventory the collector
-- fills, so they look exactly like a collection and would be billed as one.
-- There is no event for plain drag-and-drop into a GUI, so instead of trying to
-- catch each insertion we mark the collector as player-handled and skip billing
-- it; chunks_collected still runs, so the baseline keeps moving and nothing is
-- charged retroactively once they are done.
local function mark_handled(pair, tick)
  -- A tick of slack: the transfer and our sampling can land in either order.
  pair.suppress_until = tick + 1
end

register_event(defines.events.on_gui_opened, function(event)
  local entity = event.entity
  if not (entity and entity.valid and entity.name == COLLECTOR) then return end

  local pair = storage.steam_collectors and storage.steam_collectors[entity.unit_number]
  if pair then pair.gui_open = true end
end)

register_event(defines.events.on_gui_closed, function(event)
  local entity = event.entity
  if not (entity and entity.valid and entity.name == COLLECTOR) then return end

  local pair = storage.steam_collectors and storage.steam_collectors[entity.unit_number]
  if pair then
    pair.gui_open = false
    mark_handled(pair, event.tick)
  end
end)

-- Ctrl-click transfers do not need the GUI open, so they need their own hook.
register_event(defines.events.on_player_fast_transferred, function(event)
  local entity = event.entity
  if not (entity and entity.valid and entity.name == COLLECTOR) then return end

  local pair = storage.steam_collectors and storage.steam_collectors[entity.unit_number]
  if pair then mark_handled(pair, event.tick) end
end)

-- Pressing Z transfers do not need the GUI open, so they need their own hook.
register_event(defines.events.on_player_dropped_item_into_entity, function(event)
  local entity = event.entity
  if not (entity and entity.valid and entity.name == COLLECTOR) then return end

  local pair = storage.steam_collectors and storage.steam_collectors[entity.unit_number]
  if pair then mark_handled(pair, event.tick) end
end)

-- Keep the hidden tank pointing the same way when an existing collector is rotated.
register_event(defines.events.on_player_rotated_entity, function(event)
  local entity = event.entity
  if not (entity and entity.valid and entity.name == COLLECTOR) then return end

  local pair = storage.steam_collectors and storage.steam_collectors[entity.unit_number]
  if pair and pair.tank.valid then
    pair.tank.direction = entity.direction
  end
end)

-- custom_status is a writable {diode, label} shown in the entity's status line.
-- Unlike the prototype's custom_tooltip_fields, which are baked in at data stage,
-- this is per-entity and can be updated live.
-- `steam` is passed in rather than read here: this runs after the drain, so
-- re-reading the tank would show the buffer short of full every time it collects.
local function update_status(collector, tank, steam, fueled)
  local capacity = tank.prototype.fluidbox_prototypes[1].get_volume()

  local diode
  if not fueled then
    diode = defines.entity_status_diode.red      -- out of steam
  else 
    diode = defines.entity_status_diode.green    -- just landed a chunk
 end

  collector.custom_status = {
    diode = diode,
    label = {
      "chemblock.steam-usage",
      string.format("%.0f", steam),
      string.format("%.0f", capacity),
      string.format("%.0f", STEAM_PER_CHUNK),
    },
  }
end

-- How many chunks landed in the output since the last sample.
--
-- There is no way to watch the arm itself: LuaEntity exposes no arm state (every
-- arm_* field is prototype-only config), get_inventory(asteroid_collector_arm)
-- returns nil on a collector even mid-swing despite the define existing, and
-- there is no collection event. `working` only means "has power", and
-- computing_navigation never fires despite being the one status documented as
-- "Used by asteroid collectors". The output inventory is what is left.
local function chunks_collected(pair)
  local output = pair.collector.get_output_inventory()
  local count = output and output.get_item_count() or 0

  -- max(0, ...) because the count also drops when something unloads the output.
  local collected = math.max(0, count - (pair.last_output or 0))
  pair.last_output = count
  return collected
end

register_nth_tick(INTERVAL, function(event)
  storage.steam_collectors = storage.steam_collectors or {}

  for unit_number, pair in pairs(storage.steam_collectors) do
    if not (pair.collector.valid and pair.tank.valid) then
      if pair.tank.valid then pair.tank.destroy() end
      storage.steam_collectors[unit_number] = nil
    else
      local steam = pair.tank.get_fluid_count("steam")
      local fueled = steam >= STEAM_PER_CHUNK

      -- Always sample, so the baseline tracks whatever the player did, but only
      -- bill when they are not the ones moving items around.
      local collected = chunks_collected(pair)
      local player_handled = pair.gui_open
        or (pair.suppress_until ~= nil and event.tick <= pair.suppress_until)

      if fueled and collected > 0 and not player_handled then
        -- remove_fluid is positional in 2.x, and index comes first: (index, amount).
        pair.tank.remove_fluid(1, STEAM_PER_CHUNK * collected)
      end

      -- Fuel decides whether it may run at all; chunks decide what it pays.
      pair.collector.disabled_by_script = not fueled
      update_status(pair.collector, pair.tank, steam, fueled)
    end
  end
end)
