-- Space station starter pack recipe
local space_station_recipe = table.deepcopy(data.raw.recipe["space-platform-starter-pack"]) --[[@as RecipePrototype]]
space_station_recipe.name = "space-station-starter-pack"
space_station_recipe.ingredients =
    {
      {type = "item", name = "space-platform-foundation", amount = 200},
      {type = "item", name = "steel-plate", amount = 20},
    }
space_station_recipe.results = {{type="item", name="space-station-starter-pack", amount=1}}
space_station_recipe.enabled = true

-- Cupric asteroid crushing recipe
local cupric_crushing_recipe = table.deepcopy(data.raw.recipe["metallic-asteroid-crushing"])
cupric_crushing_recipe.name = "cupric-asteroid-crushing"
cupric_crushing_recipe.ingredients = {
    {type = "item", name = "cupric-asteroid-chunk", amount = 1}
}
cupric_crushing_recipe.icons = {
    {
    icon = cupric_crushing_recipe.icon,
    icon_size = cupric_crushing_recipe.icon_size,
    tint = {r=1,g=0.6,b=0}
  },
}
cupric_crushing_recipe.results =
    {
      {type = "item", name = "copper-ore", amount = 20},
      {type = "item", name = "cupric-asteroid-chunk", amount = 1, independent_probability = 0.3}
    }
cupric_crushing_recipe.enabled = true

-- Steam furnace recipe
local steam_furnace_recipe = table.deepcopy(data.raw.recipe["stone-furnace"])
steam_furnace_recipe.name = "steam-furnace"
steam_furnace_recipe.icons = data.raw.item["steam-furnace"].icons
steam_furnace_recipe.ingredients =
    {
      {type = "item", name = "stone", amount = 10},
      {type = "item", name = "pipe", amount = 4},
    }
steam_furnace_recipe.results = {{type = "item", name = "steam-furnace", amount = 1}}
steam_furnace_recipe.enabled = true

-- Stone crushing recipe
local stone_crushing_recipe = {
    type = "recipe",
    name = "stone-crushing",
    categories = {"crushing"},
    icons = data.raw.item["sand"].icons,
    ingredients = {
        {type = "item", name = "stone", amount = 1}
    },
    results = {
        {type = "item", name = "sand", amount = 1}
    },
    enabled = true,
}


data:extend(
    {
        space_station_recipe,
        cupric_crushing_recipe,
        steam_furnace_recipe,
        stone_crushing_recipe
    }
)