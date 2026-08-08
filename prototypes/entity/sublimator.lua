local sublimator = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])
sublimator.name = "sublimator"
sublimator.icons = {
    {
    icon = sublimator.icon,
    icon_size = sublimator.icon_size,
    tint = {r=0.5,g=0.5,b=1}
    }
}

sublimator.crafting_categories = {"sublimating"}
sublimator.crafting_speed = 1
sublimator.energy_source = {
  type = "void"
}

data:extend({
    sublimator,
})