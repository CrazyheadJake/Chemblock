local space_station_recipe = table.deepcopy(data.raw.recipe["space-platform-starter-pack"]) --[[@as RecipePrototype]]
space_station_recipe.name = "space-station-starter-pack"
space_station_recipe.ingredients =
    {
      {type = "item", name = "space-platform-foundation", amount = 200},
      {type = "item", name = "steel-plate", amount = 20},
    }
space_station_recipe.results = {{type="item", name="space-station-starter-pack", amount=1}}
space_station_recipe.enabled = true

local cupric_crushing_recipe = table.deepcopy(data.raw.recipe["metallic-asteroid-crushing"])
cupric_crushing_recipe.name = "cupric-asteroid-crushing"
cupric_crushing_recipe.ingredients = {
    {type = "item", name = "cupric-asteroid-chunk", amount = 1}
}
cupric_crushing_recipe.results =
    {
      {type = "item", name = "copper-ore", amount = 20},
      {type = "item", name = "cupric-asteroid-chunk", amount = 1, independent_probability = 0.3}
    }
cupric_crushing_recipe.enabled = true

data:extend(
    {
        space_station_recipe,
        cupric_crushing_recipe
    }
)