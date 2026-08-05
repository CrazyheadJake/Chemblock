local steam_furnace = table.deepcopy(data.raw.furnace["stone-furnace"])
steam_furnace.name = "steam-furnace"
steam_furnace.icons = {
    {
    icon = steam_furnace.icon,
    icon_size = steam_furnace.icon_size,
    tint = {r=0.8,g=0.8,b=1}
  },
}
data.raw.fluid["steam"].fuel_value = "20kJ"
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

data:extend(
    {
        steam_furnace,
    }
)