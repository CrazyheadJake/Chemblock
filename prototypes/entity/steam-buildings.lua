local steam_furnace = table.deepcopy(data.raw.furnace["stone-furnace"])
steam_furnace.name = "steam-furnace"
steam_furnace.icons = {
    {
    icon = steam_furnace.icon,
    icon_size = steam_furnace.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
steam_furnace.energy_source = {
  type = "fluid",
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 200,
    pipe_covers = pipecoverspictures(),
    -- render_layer = "higher-object-above",
    pipe_connections =
    {
      {flow_direction = "input-output", direction = defines.direction.north, position = {-0.5, -0.5}},
      {flow_direction = "input-output", direction = defines.direction.south, position = {0.5, 0.5}},
    },
  },
  burns_fluid = true,        
  effectivity = 1,
  maximum_temperature = 165,  -- same cap the vanilla steam engine uses
}

steam_furnace.minable.result = "steam-furnace"
steam_furnace.surface_conditions = {}
steam_furnace.use_mirroring = true

local steam_crusher = table.deepcopy(data.raw["assembling-machine"]["crusher"])
steam_crusher.name = "steam-crusher"
steam_crusher.icons = {
    {
    icon = steam_crusher.icon,
    icon_size = steam_crusher.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
steam_crusher.energy_source = {
  type = "fluid",
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 200,
    pipe_covers = pipecoverspictures(),
    -- render_layer = "higher-object-above",
    pipe_connections =
    {
      {flow_direction = "input", direction = defines.direction.west, position = {-0.5, 0}},
    },
  },
  burns_fluid = true,        
  effectivity = 1,
  maximum_temperature = 165,  -- same cap the vanilla steam engine uses
}
steam_crusher.minable.result = "steam-crusher"
steam_crusher.surface_conditions = {}
steam_crusher.use_mirroring = true

local steam_asteroid_collector= table.deepcopy(data.raw["asteroid-collector"]["asteroid-collector"])
steam_asteroid_collector.name = "steam-asteroid-collector"
steam_asteroid_collector.icons = {
    {
    icon = steam_asteroid_collector.icon,
    icon_size = steam_asteroid_collector.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
-- AsteroidCollectorPrototype only accepts ElectricEnergySource or
-- VoidEnergySource -- there is no fluid option, and no fluid_box field on the
-- prototype at all. So it stays electric, and a hidden generator sitting at the
-- same position converts steam into power for it. The engine then handles
-- throttling for free: the collector already falls back to arm_slow_energy_usage
-- when arm_energy_usage isn't met, so low steam means slow collection.
steam_asteroid_collector.energy_source = {
  type = "electric",
  usage_priority = "secondary-input",
  render_no_network_icon = false,
  render_no_power_icon = false,
}
-- Vanilla is 0.3, i.e. collectors keep working at 30% with no power at all.
-- Zero it so no steam genuinely means no collection.
steam_asteroid_collector.unpowered_arm_speed_scale = 0
steam_asteroid_collector.minable.result = "steam-asteroid-collector"
steam_asteroid_collector.custom_tooltip_fields = nil

local hidden_flags = {
  "placeable-off-grid", "not-on-map", "not-deconstructable", "not-blueprintable",
  "no-copy-paste", "not-selectable-in-game", "not-repairable", "not-upgradable",
}

-- The actual steam consumer. Invisible (no `pictures`), but its pipe connection
-- and covers still render, so the player can see where to attach a pipe.
-- scale_fluid_usage means it only burns steam proportional to real demand rather
-- than running flat out whenever steam is present.
local collector_generator = {
  type = "generator",
  name = "steam-asteroid-collector-generator",
  flags = hidden_flags,
  max_power_output = "100kW",
  scale_fluid_usage = true,
  fluid_usage_per_tick = 0.05,
  maximum_temperature = 165,
  effectivity = 1,
  -- Empty layers means it still collides with nothing, but the box itself has to
  -- match the 3x3 collector: pipe connection positions must lie inside the
  -- bounding box, and {0,0} left nowhere to put one.
  collision_mask = {layers = {}},
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  energy_source = {type = "electric", usage_priority = "secondary-output"},
  fluid_box = {
    production_type = "input",
    filter = "steam",
    volume = 200,
    pipe_covers = pipecoverspictures(),
    pipe_connections = {
      -- y = 1 is the centre of the southern tile row of a 3x3, so the connection
      -- lands on the collector's south edge.
      {flow_direction = "input", direction = defines.direction.south, position = {0, 1}},
    },
  },
}

-- Bridges the hidden generator and the collector into a shared network. Neither
-- connects to the other directly; both only join by sitting in a pole's supply
-- area. maximum_wire_distance = 0 keeps it from being wired to anything else.
local collector_pole = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])
collector_pole.name = "steam-asteroid-collector-pole"
collector_pole.flags = hidden_flags
collector_pole.collision_mask = {layers = {}}
collector_pole.collision_box = {{0, 0}, {0, 0}}
collector_pole.selection_box = nil
collector_pole.minable = nil
collector_pole.supply_area_distance = 1
collector_pole.maximum_wire_distance = 0
collector_pole.pictures = nil
collector_pole.active_picture = nil

data:extend({
    steam_furnace,
    steam_crusher,
    steam_asteroid_collector,
    collector_generator,
    collector_pole,
})