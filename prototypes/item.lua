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
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
steam_furnace_item.place_result = "steam-furnace"

-- Steam crusher
local steam_crusher_item = table.deepcopy(data.raw.item["crusher"])
steam_crusher_item.name = "steam-crusher"
steam_crusher_item.icons = {
    {
    icon = steam_crusher_item.icon,
    icon_size = steam_crusher_item.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
steam_crusher_item.place_result = "steam-crusher"

-- Steam asteroid collector
local steam_asteroid_collector_item = table.deepcopy(data.raw.item["asteroid-collector"])
steam_asteroid_collector_item.name = "steam-asteroid-collector"
steam_asteroid_collector_item.icons = {
    {
    icon = steam_asteroid_collector_item.icon,
    icon_size = steam_asteroid_collector_item.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
steam_asteroid_collector_item.place_result = "steam-asteroid-collector"

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
local sand = table.deepcopy(data.raw.item["stone"])
sand.name = "sand"
sand.stack_size = 100
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

-- Solar inserter
local solar_inserter_item = table.deepcopy(data.raw.item["burner-inserter"])
solar_inserter_item.name = "solar-inserter"
solar_inserter_item.icons = {
    {
    icon = solar_inserter_item.icon,
    icon_size = solar_inserter_item.icon_size,
    tint = {r=1,g=0.4,b=0}
  }
}
solar_inserter_item.place_result = "solar-inserter"

-- Glass
local glass = table.deepcopy(data.raw.item["iron-plate"])
glass.name = "glass"
glass.icons = {
    {
    icon = glass.icon,
    icon_size = glass.icon_size,
    tint = {r=1,g=1,b=1,a=0.5}
  }
}

data:extend({
    cupric_asteroid_chunk,
    steam_furnace_item,
    steam_crusher_item,
    steam_asteroid_collector_item,
    simple_heat_exchanger,
    sand,
    sublimator_item,
    solar_heater_item,
    solar_inserter_item,
    glass,
})