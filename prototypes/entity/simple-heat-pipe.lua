local simple_heat_pipe = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
simple_heat_pipe.name = "simple-heat-pipe"
simple_heat_pipe.icons = {
  {
    icon = simple_heat_pipe.icon,
    icon_size = simple_heat_pipe.icon_size,
    tint = { r = 0.8, g = 0.8, b = 1 }
  },
}
simple_heat_pipe.minable.result = "simple-heat-pipe"
simple_heat_pipe.heat_buffer.max_temperature = 300
simple_heat_pipe.heat_buffer.specific_heat = "10kJ"

data:extend({
  simple_heat_pipe
})
