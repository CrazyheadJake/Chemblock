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
steam_asteroid_collector.energy_source = {
  type = "void",
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 200,
    pipe_covers = pipecoverspictures(),
    -- render_layer = "higher-object-above",
    pipe_connections =
    {
      {flow_direction = "input", direction = defines.direction.south, position = {0, 0.5}},
    },
  },
  burns_fluid = true,        
  effectivity = 1,
  maximum_temperature = 165,  -- same cap the vanilla steam engine uses
}
steam_asteroid_collector.minable.result = "steam-asteroid-collector"

data:extend({
    steam_furnace,
    steam_crusher,
    steam_asteroid_collector
})