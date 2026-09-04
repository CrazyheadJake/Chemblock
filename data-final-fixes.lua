local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

-- Asteroid spawning edits
table.insert(data.raw.planet.nauvis.asteroid_spawn_definitions,
  {
    type = "asteroid-chunk",
    asteroid = "cupric-asteroid-chunk",
    probability = 0.0125,
    speed = asteroid_util.standard_speed,
    angle_when_stopped = asteroid_util.chunk_angle,
  }
)

table.insert(data.raw.planet.nauvis.asteroid_spawn_definitions,
  {
    type = "entity",
    asteroid = "resource-asteroid",
    probability = 0.006125,
    speed = asteroid_util.standard_speed,
    angle_when_stopped = asteroid_util.chunk_angle,
  }
)

-- Give steam a fuel value
data.raw.fluid["steam"].fuel_value = "20kJ"

-- Recipe edits
data.raw.recipe["carbonic-asteroid-crushing"].results = {
  { type = "item", name = "stone",                   amount = 10 },
  { type = "item", name = "carbonic-asteroid-chunk", amount = 1, independent_probability = 0.3 }
}

data.raw.recipe["space-platform-foundation"].ingredients = {
  { type = "item", name = "stone",      amount = 5 },
  { type = "item", name = "iron-plate", amount = 8 },
}

-- Remove items that aren't needed
data.raw.recipe["burner-inserter"].enabled = false
data.raw.recipe["burner-mining-drill"].enabled = false
data.raw.recipe["stone-furnace"].enabled = false

-- Science pack edits
data.raw.recipe["automation-science-pack"].ingredients = {
  { type = "item", name = "iron-gear-wheel", amount = 1 },
  { type = "item", name = "copper-plate",    amount = 1 },
  { type = "item", name = "ice",             amount = 1 },
}

-- Disable burner inserter
data.raw.recipe["burner-inserter"].enabled = false

-- Technology edits
require("prototypes.technology")

-- Allow items to be placed on space platform

-- Both work on regular platforms (pressure 0) and space stations (pressure
-- 500), but not on any planet (pressure >= 1000 everywhere -- see
-- prototypes/planet/*.lua). Matches prototypes/entity/steam-buildings.lua's
-- steam-crusher / steam-asteroid-collector, which use the same condition.
local platform_pressure_surface_conditions = { { property = "pressure", min = 0, max = 500 } }
data.raw["asteroid-collector"]["asteroid-collector"].surface_conditions = platform_pressure_surface_conditions
data.raw["assembling-machine"]["crusher"].surface_conditions = platform_pressure_surface_conditions
