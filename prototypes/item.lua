local function make_tile_area(area, name)
  local result = {}
  local left_top = area[1]
  local right_bottom = area[2]
  for x = left_top[1], right_bottom[1] do
    for y = left_top[2], right_bottom[2] do
      table.insert(result, {position = {x, y}, tile = name})
    end
  end
  return result
end

-- Space station starter pack
local space_station_starter_pack = table.deepcopy(data.raw["space-platform-starter-pack"]["space-platform-starter-pack"]) --[[@as SpacePlatformStarterPackPrototype]]
space_station_starter_pack.name = "space-station-starter-pack"
space_station_starter_pack.icons = {
    {
    icon = space_station_starter_pack.icon,
    icon_size = space_station_starter_pack.icon_size,
    tint = {r=1,g=0,b=0.8}
  },
}
space_station_starter_pack.tiles = make_tile_area({{-20, -20}, {19, 19}}, "space-platform-foundation")
space_station_starter_pack.initial_items = nil
space_station_starter_pack.create_electric_network = false

-- Cupric asteroid chunk
local cupric_asteroid_chunk = table.deepcopy(data.raw.item["metallic-asteroid-chunk"])
cupric_asteroid_chunk.name = "cupric-asteroid-chunk"
cupric_asteroid_chunk.icons = {
    {
    icon = cupric_asteroid_chunk.icon,
    icon_size = cupric_asteroid_chunk.icon_size,
    tint = {r=1,g=0.6,b=0}
  },
}

-- Steam furnace
local steam_furnace_item = table.deepcopy(data.raw.item["stone-furnace"])
steam_furnace_item.name = "steam-furnace"
steam_furnace_item.icons = {
    {
    icon = steam_furnace_item.icon,
    icon_size = steam_furnace_item.icon_size,
    tint = {r=0.8,g=0.8,b=1}
  },
}
steam_furnace_item.place_result = "steam-furnace"

-- Simple heat exchanger
local simple_heat_exchanger = table.deepcopy(data.raw.item["heat-exchanger"])
simple_heat_exchanger.name = "simple-heat-exchanger"
simple_heat_exchanger.icons = {
    {
    icon = simple_heat_exchanger.icon,
    icon_size = simple_heat_exchanger.icon_size,
    tint = {r=0.8,g=0.8,b=1}
  },
}
simple_heat_exchanger.place_result = "simple-heat-exchanger"

-- Sand
local sand = {
  stack_size = 100,
  name = "sand",
  type = "item",
}
sand.icons = {
    {
    icon = data.raw.item["lithium"].icon,
    icon_size = data.raw.item["lithium"].icon_size,
    tint = {r=1,g=0.9,b=0.6}
  },
}

-- Sublimator
local sublimator_item = table.deepcopy(data.raw.item["assembling-machine-2"])
sublimator_item.name = "sublimator"
sublimator_item.icons = {
    {
    icon = sublimator_item.icon,
    icon_size = sublimator_item.icon_size,
    tint = {r=0.5,g=0.5,b=1}
  },
}
sublimator_item.place_result = "sublimator"

-- Solar heater
local solar_heater_item = table.deepcopy(data.raw.item["solar-panel"])
solar_heater_item.name = "solar-heater"
solar_heater_item.icons = {
    {
    icon = solar_heater_item.icon,
    icon_size = solar_heater_item.icon_size,
    tint = {r=1,g=0.4,b=0}
  }
}
solar_heater_item.place_result = "solar-heater"

data:extend(
    {
        space_station_starter_pack,
        cupric_asteroid_chunk,
        steam_furnace_item,
        simple_heat_exchanger,
        sand,
        sublimator_item,
        solar_heater_item,
    }
)