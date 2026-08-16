data:extend({
  {
    type = "recipe-category",
    name = "sublimating"
  }
})

local recipes = {}

-- Space station starter pack recipe
local space_station_recipe = table.deepcopy(data.raw.recipe["space-platform-starter-pack"]) --[[@as RecipePrototype]]
space_station_recipe.name = "space-station-starter-pack"
space_station_recipe.ingredients =
{
  { type = "item", name = "space-platform-foundation", amount = 200 },
  { type = "item", name = "steel-plate",               amount = 20 },
}
space_station_recipe.results = { { type = "item", name = "space-station-starter-pack", amount = 1 } }
space_station_recipe.enabled = false
recipes.space_station = space_station_recipe

-- Cupric asteroid crushing recipe
local cupric_crushing_recipe = table.deepcopy(data.raw.recipe["metallic-asteroid-crushing"])
cupric_crushing_recipe.name = "cupric-asteroid-crushing"
cupric_crushing_recipe.ingredients = {
  { type = "item", name = "cupric-asteroid-chunk", amount = 1 }
}
cupric_crushing_recipe.icons = {
  {
    icon = cupric_crushing_recipe.icon,
    icon_size = cupric_crushing_recipe.icon_size,
    tint = { r = 1, g = 0.6, b = 0 }
  },
}
cupric_crushing_recipe.results =
{
  { type = "item", name = "copper-ore",            amount = 20 },
  { type = "item", name = "cupric-asteroid-chunk", amount = 1, independent_probability = 0.3 }
}
cupric_crushing_recipe.enabled = false
recipes.cupric_crushing = cupric_crushing_recipe

-- Steam furnace recipe
local steam_furnace_recipe = table.deepcopy(data.raw.recipe["stone-furnace"])
steam_furnace_recipe.name = "steam-furnace"
steam_furnace_recipe.icons = data.raw.item["steam-furnace"].icons
steam_furnace_recipe.ingredients =
{
  { type = "item", name = "stone", amount = 10 },
  { type = "item", name = "pipe",  amount = 4 },
}
steam_furnace_recipe.results = { { type = "item", name = "steam-furnace", amount = 1 } }
steam_furnace_recipe.enabled = false
recipes.steam_furnace = steam_furnace_recipe

-- Steam crusher recipe
local steam_crusher_recipe = table.deepcopy(data.raw.recipe["crusher"])
steam_crusher_recipe.name = "steam-crusher"
steam_crusher_recipe.icons = data.raw.item["steam-crusher"].icons
steam_crusher_recipe.ingredients =
{
  { type = "item", name = "stone-brick",     amount = 5 },
  { type = "item", name = "pipe",            amount = 6 },
  { type = "item", name = "iron-gear-wheel", amount = 10 },
}
steam_crusher_recipe.results = { { type = "item", name = "steam-crusher", amount = 1 } }
steam_crusher_recipe.enabled = false
recipes.steam_crusher = steam_crusher_recipe

-- Steam asteroid collector recipe
local steam_asteroid_collector_recipe = table.deepcopy(data.raw.recipe["asteroid-collector"])
steam_asteroid_collector_recipe.name = "steam-asteroid-collector"
steam_asteroid_collector_recipe.icons = data.raw.item["steam-asteroid-collector"].icons
steam_asteroid_collector_recipe.ingredients =
{
  { type = "item", name = "stone-brick", amount = 10 },
  { type = "item", name = "pipe",        amount = 8 },
  { type = "item", name = "iron-plate",  amount = 12 },
}
steam_asteroid_collector_recipe.results = { { type = "item", name = "steam-asteroid-collector", amount = 1 } }
steam_asteroid_collector_recipe.enabled = false
recipes.steam_asteroid_collector = steam_asteroid_collector_recipe

-- Steam lab recipe
recipes.steam_lab = {
  type = "recipe",
  name = "steam-lab",
  categories = { "crafting" },
  icons = data.raw.item["steam-lab"].icons,
  ingredients = {
    { type = "item", name = "transport-belt",  amount = 4 },
    { type = "item", name = "pipe",            amount = 8 },
    { type = "item", name = "iron-gear-wheel", amount = 10 },
    { type = "item", name = "glass",           amount = 10 },
    { type = "item", name = "copper-cable",    amount = 8 },
  },
  results = {
    { type = "item", name = "steam-lab", amount = 1 }
  },
  enabled = false
}

-- Steam assembler
recipes.steam_assembler = {
  type = "recipe",
  name = "steam-assembling-machine",
  categories = { "crafting" },
  icons = data.raw.item["steam-assembling-machine"].icons,
  ingredients = {
    { type = "item", name = "stone-brick",     amount = 10 },
    { type = "item", name = "pipe",            amount = 6 },
    { type = "item", name = "iron-gear-wheel", amount = 5 },
  },
  results = {
    { type = "item", name = "steam-assembling-machine", amount = 1 }
  },
  enabled = false
}

-- Simple heat exchanger recipe
recipes.simple_heat_exchanger = {
  type = "recipe",
  name = "simple-heat-exchanger",
  categories = { "crafting" },
  icons = data.raw.item["simple-heat-exchanger"].icons,
  ingredients = {
    { type = "item", name = "copper-plate",    amount = 20 },
    { type = "item", name = "iron-gear-wheel", amount = 10 },
    { type = "item", name = "pipe",            amount = 8 }
  },
  results = {
    { type = "item", name = "simple-heat-exchanger", amount = 1 }
  },
  enabled = false
}

-- Stone crushing recipe
recipes.stone_crushing = {
  type = "recipe",
  name = "stone-crushing",
  categories = { "crushing" },
  icons = data.raw.item["sand"].icons,
  energy_required = 2,
  ingredients = {
    { type = "item", name = "stone", amount = 1 }
  },
  results = {
    { type = "item", name = "sand", amount = 1 }
  },
  enabled = false
}

-- Hand-crafted stone crushing.
recipes.stone_crushing_by_hand = {
  type = "recipe",
  name = "stone-crushing-by-hand",
  categories = { "hand-crafting" },
  icons = data.raw.item["sand"].icons,
  energy_required = 4,
  ingredients = {
    { type = "item", name = "stone", amount = 1 }
  },
  results = {
    { type = "item", name = "sand", amount = 1 }
  },
  enabled = true,
}

-- Sublimator recipe
recipes.sublimator = {
  type = "recipe",
  name = "sublimator",
  categories = { "crafting" },
  icons = data.raw.item["sublimator"].icons,
  energy_required = 2,
  ingredients = {
    { type = "item", name = "sand",            amount = 12 },
    { type = "item", name = "iron-plate",      amount = 8 },
    { type = "item", name = "iron-gear-wheel", amount = 4 },
  },
  results = {
    { type = "item", name = "sublimator", amount = 1 }
  },
  enabled = true
}

-- Ice sublimation recipe
recipes.ice_sublimation = {
  type = "recipe",
  name = "ice-sublimation",
  categories = { "sublimating" },
  icons = {
    {
      icon = data.raw.fluid["steam"].icon,
      icon_size = data.raw.fluid["steam"].icon_size,
    }
  },
  ingredients = {
    { type = "item", name = "ice", amount = 1 }
  },
  results = {
    { type = "fluid", name = "steam", amount = 100 }
  },
  enabled = true,
  energy_required = 5,
}

-- Solar heater
recipes.solar_heater = {
  type = "recipe",
  name = "solar-heater",
  categories = { "crafting" },
  icons = data.raw.item["solar-heater"].icons,
  energy_required = 4,
  ingredients = {
    { type = "item", name = "copper-plate", amount = 20 },
    { type = "item", name = "iron-plate",   amount = 20 },
    { type = "item", name = "pipe",         amount = 10 }
  },
  results = {
    { type = "item", name = "solar-heater", amount = 1 }
  },
  enabled = false
}

-- Solar inserter
recipes.solar_inserter = {
  type = "recipe",
  name = "solar-inserter",
  categories = { "crafting" },
  icons = data.raw.item["solar-inserter"].icons,
  energy_required = 4,
  ingredients = {
    { type = "item", name = "iron-gear-wheel", amount = 6 },
    { type = "item", name = "glass",           amount = 4 },
    { type = "item", name = "ice",             amount = 3 }
  },
  results = {
    { type = "item", name = "solar-inserter", amount = 1 }
  },
  enabled = true
}

-- Glass
recipes.glass = {
  type = "recipe",
  name = "glass",
  categories = { "smelting" },
  icons = data.raw.item["glass"].icons,
  energy_required = 4,
  ingredients = {
    { type = "item", name = "sand", amount = 2 },
  },
  results = {
    { type = "item", name = "glass", amount = 1 }
  },
  enabled = true
}

-- Simple heat pipe
recipes.simple_heat_pipe = {
  type = "recipe",
  name = "simple-heat-pipe",
  categories = { "crafting" },
  icons = data.raw.item["simple-heat-pipe"].icons,
  energy_required = 2,
  ingredients = {
    { type = "item", name = "iron-plate",   amount = 3 },
    { type = "item", name = "copper-cable", amount = 12 },
  },
  results = {
    { type = "item", name = "simple-heat-pipe", amount = 1 }
  },
  enabled = false
}

for _, recipe in pairs(recipes) do
  data:extend({ recipe })
end
