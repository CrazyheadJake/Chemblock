local solar_inserter = table.deepcopy(data.raw["inserter"]["burner-inserter"])
solar_inserter.name = "solar-inserter"
solar_inserter.icons = {
  {
    icon = solar_inserter.icon,
    icon_size = solar_inserter.icon_size,
    tint = { r = 1, g = 0.4, b = 0 }
  }
}
solar_inserter.energy_source = {
  type = "void"
}
solar_inserter.minable = { mining_time = 0.1, result = "solar-inserter" }
solar_inserter.surface_conditions = nil
solar_inserter.rotation_speed = 0.006

data:extend({
  solar_inserter,
})
