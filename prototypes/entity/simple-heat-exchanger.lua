local simple_heat_exchanger = table.deepcopy(data.raw.boiler["heat-exchanger"])
simple_heat_exchanger.name = "simple-heat-exchanger"
simple_heat_exchanger.icons = {
    {
    icon = simple_heat_exchanger.icon,
    icon_size = simple_heat_exchanger.icon_size,
    tint = {r=0.8,g=0.8,b=1}
  },
}
simple_heat_exchanger.minable.result = "simple-heat-exchanger"
simple_heat_exchanger.target_temperature = 165
simple_heat_exchanger.energy_consumption = "1.8MW"

data:extend(
    {
        simple_heat_exchanger,
    }
)