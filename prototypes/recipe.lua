local spaceStationRecipe = table.deepcopy(data.raw.recipe["space-platform-starter-pack"]) --[[@as RecipePrototype]]
spaceStationRecipe.name = "space-station-starter-pack"
spaceStationRecipe.ingredients =
    {
      {type = "item", name = "space-platform-foundation", amount = 200},
      {type = "item", name = "steel-plate", amount = 20},
    }
spaceStationRecipe.results = {{type="item", name="space-station-starter-pack", amount=1}}
spaceStationRecipe.enabled = true


data:extend(
    {
        spaceStationRecipe
    }
)