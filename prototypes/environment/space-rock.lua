local big_space_rock = table.deepcopy(data.raw["simple-entity"]["big-volcanic-rock"])
big_space_rock.name = "big-space-rock"
-- The clone inherits Vulcanus map-gen placement; platforms aren't map-generated
-- anyway, and leaving it would scatter these across Vulcanus.
big_space_rock.autoplace = nil
big_space_rock.minable.results = {
    {type = "item", name = "copper-ore", amount_min = 4, amount_max=10},
    {type = "item", name = "iron-ore", amount_min = 4, amount_max=10},
    {type = "item", name = "stone", amount_min = 4, amount_max=10},
    {type = "item", name = "ice", amount_min = 10, amount_max=20},
}

data:extend(
    {
        big_space_rock,
    }
)