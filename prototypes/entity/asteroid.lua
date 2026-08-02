local cupric_asteroid_chunk = table.deepcopy(data.raw["asteroid-chunk"]["metallic-asteroid-chunk"])
cupric_asteroid_chunk.name = "cupric-asteroid-chunk"
cupric_asteroid_chunk.icons = {
    {
    icon = cupric_asteroid_chunk.icon,
    icon_size = cupric_asteroid_chunk.icon_size,
    tint = {r=1,g=0.6,b=0}
  },
}
cupric_asteroid_chunk.minable.results = {
    {type="item", name="cupric-asteroid-chunk", amount=1}
}
cupric_asteroid_chunk.graphics_set.lights[2] = {color = {0, 1, 0}, direction = {-1, -45, 0.1}}

data:extend(
    {
        cupric_asteroid_chunk,
    }
)
