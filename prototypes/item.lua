local items = {}

-- Cupric asteroid chunk
local cupric_asteroid_chunk = table.deepcopy(data.raw.item["metallic-asteroid-chunk"])
cupric_asteroid_chunk.name = "cupric-asteroid-chunk"
cupric_asteroid_chunk.icons = {
  {
    icon = cupric_asteroid_chunk.icon,
    icon_size = cupric_asteroid_chunk.icon_size,
    tint = { r = 1, g = 0.6, b = 0 }
  },
}
items.cupric_asteroid_chunk = cupric_asteroid_chunk

-- Steam furnace
local steam_furnace_item = table.deepcopy(data.raw.item["stone-furnace"])
steam_furnace_item.name = "steam-furnace"
steam_furnace_item.icons = {
  {
    icon = steam_furnace_item.icon,
    icon_size = steam_furnace_item.icon_size,
    tint = { r = 0.6, g = 0.6, b = 0.6 }
  },
}
steam_furnace_item.place_result = "steam-furnace"
items.steam_furnace = steam_furnace_item

-- Steam crusher
local steam_crusher_item = table.deepcopy(data.raw.item["crusher"])
steam_crusher_item.name = "steam-crusher"
steam_crusher_item.icons = {
  {
    icon = steam_crusher_item.icon,
    icon_size = steam_crusher_item.icon_size,
    tint = { r = 0.6, g = 0.6, b = 0.6 }
  },
}
steam_crusher_item.place_result = "steam-crusher"
items.steam_crusher = steam_crusher_item

-- Steam asteroid collector
local steam_asteroid_collector_item = table.deepcopy(data.raw.item["asteroid-collector"])
steam_asteroid_collector_item.name = "steam-asteroid-collector"
steam_asteroid_collector_item.icons = {
  {
    icon = steam_asteroid_collector_item.icon,
    icon_size = steam_asteroid_collector_item.icon_size,
    tint = { r = 0.6, g = 0.6, b = 0.6 }
  },
}
steam_asteroid_collector_item.place_result = "steam-asteroid-collector"
items.steam_asteroid_collector = steam_asteroid_collector_item

-- Steam lab
local steam_lab_item = table.deepcopy(data.raw.item["lab"])
steam_lab_item.name = "steam-lab"
steam_lab_item.icons = {
  {
    icon = steam_lab_item.icon,
    icon_size = steam_lab_item.icon_size,
    tint = { r = 0.3, g = 0.3, b = 0.3 }
  },
}
steam_lab_item.place_result = "steam-lab"
items.steam_lab = steam_lab_item

-- Steam assembler
local steam_assembler = table.deepcopy(data.raw.item["assembling-machine-1"])
steam_assembler.name = "steam-assembling-machine"
steam_assembler.icons = {
  {
    icon = steam_assembler.icon,
    icon_size = steam_assembler.icon_size,
    tint = { r = 0.3, g = 0.3, b = 0.3 }
  },
}
steam_assembler.place_result = "steam-assembling-machine"
items.steam_assembler = steam_assembler

-- Simple heat exchanger
local simple_heat_exchanger = table.deepcopy(data.raw.item["heat-exchanger"])
simple_heat_exchanger.name = "simple-heat-exchanger"
simple_heat_exchanger.icons = {
  {
    icon = simple_heat_exchanger.icon,
    icon_size = simple_heat_exchanger.icon_size,
    tint = { r = 0.8, g = 0.8, b = 1 }
  },
}
simple_heat_exchanger.place_result = "simple-heat-exchanger"
items.simple_heat_exchanger = simple_heat_exchanger

-- Sand
local sand = table.deepcopy(data.raw.item["stone"])
sand.name = "sand"
sand.stack_size = 100
sand.icons = {
  {
    icon = data.raw.item["lithium"].icon,
    icon_size = data.raw.item["lithium"].icon_size,
    tint = { r = 1, g = 0.9, b = 0.6 }
  },
}
items.sand = sand

-- Sublimator
local sublimator_item = table.deepcopy(data.raw.item["assembling-machine-2"])
sublimator_item.name = "sublimator"
sublimator_item.icons = {
  {
    icon = sublimator_item.icon,
    icon_size = sublimator_item.icon_size,
    tint = { r = 0.5, g = 0.5, b = 1 }
  },
}
sublimator_item.place_result = "sublimator"
items.sublimator = sublimator_item

-- Solar heater
local solar_heater_item = table.deepcopy(data.raw.item["solar-panel"])
solar_heater_item.name = "solar-heater"
solar_heater_item.icons = {
  {
    icon = solar_heater_item.icon,
    icon_size = solar_heater_item.icon_size,
    tint = { r = 1, g = 0.4, b = 0 }
  }
}
solar_heater_item.place_result = "solar-heater"
items.solar_heater = solar_heater_item

-- Solar inserter
local solar_inserter_item = table.deepcopy(data.raw.item["burner-inserter"])
solar_inserter_item.name = "solar-inserter"
solar_inserter_item.icons = {
  {
    icon = solar_inserter_item.icon,
    icon_size = solar_inserter_item.icon_size,
    tint = { r = 1, g = 0.4, b = 0 }
  }
}
solar_inserter_item.place_result = "solar-inserter"
items.solar_inserter = solar_inserter_item

-- Glass
local glass = table.deepcopy(data.raw.item["iron-plate"])
glass.name = "glass"
glass.icons = {
  {
    icon = glass.icon,
    icon_size = glass.icon_size,
    tint = { r = 1, g = 1, b = 1, a = 0.5 }
  }
}
items.glass = glass

-- Simple heat pipe
local simple_heat_pipe = table.deepcopy(data.raw.item["heat-pipe"])
simple_heat_pipe.name = "simple-heat-pipe"
simple_heat_pipe.icons = {
  {
    icon = simple_heat_pipe.icon,
    icon_size = simple_heat_pipe.icon_size,
    tint = { r = 0.8, g = 0.8, b = 1 }
  }
}
simple_heat_pipe.place_result = "simple-heat-pipe"
items.simple_heat_pipe = simple_heat_pipe

-- Iron electric pole
local iron_electric_pole = table.deepcopy(data.raw.item["small-electric-pole"])
iron_electric_pole.name = "iron-electric-pole"
iron_electric_pole.icons = {
  {
    icon = iron_electric_pole.icon,
    icon_size = iron_electric_pole.icon_size,
    tint = { r = 0.6, g = 0.65, b = 0.75 }
  }
}
iron_electric_pole.place_result = "iron-electric-pole"
items.iron_electric_pole = iron_electric_pole

for _, item in pairs(items) do
  data:extend({ item })
end
