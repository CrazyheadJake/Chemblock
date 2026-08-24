local iron_electric_pole = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])
local tint = { r = 0.6, g = 0.65, b = 0.75 }

iron_electric_pole.name = "iron-electric-pole"
iron_electric_pole.icons = {
  {
    icon = iron_electric_pole.icon,
    icon_size = iron_electric_pole.icon_size,
    tint = tint
  },
}
iron_electric_pole.minable.result = "iron-electric-pole"

-- layers[1] is the pole itself; layers[2] is the shadow, which must stay
-- untinted or it stops reading as a shadow.
iron_electric_pole.pictures.layers[1].tint = tint
iron_electric_pole.water_reflection.pictures.tint = tint

data:extend({
  iron_electric_pole,
})
