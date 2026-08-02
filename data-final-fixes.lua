local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

table.insert(data.raw.planet.nauvis.asteroid_spawn_definitions,
  {
    type = "asteroid-chunk",
    asteroid = "cupric-asteroid-chunk",
    probability = 0.0125,
    speed = asteroid_util.standard_speed,
    angle_when_stopped = asteroid_util.chunk_angle,
  }
)

data.raw.recipe["metallic-asteroid-crushing"].enabled = true
data.raw.recipe["oxide-asteroid-crushing"].enabled = true
data.raw.recipe["carbonic-asteroid-crushing"].enabled = true
