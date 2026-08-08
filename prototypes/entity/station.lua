local function make_tile_area(area, name)
  local result = {}
  local left_top = area[1]
  local right_bottom = area[2]
  for x = left_top[1], right_bottom[1] do
    for y = left_top[2], right_bottom[2] do
      table.insert(result, {position = {x, y}, tile = name})
    end
  end
  return result
end

-- Space station starter pack
local space_station_starter_pack = table.deepcopy(data.raw["space-platform-starter-pack"]["space-platform-starter-pack"]) --[[@as SpacePlatformStarterPackPrototype]]
space_station_starter_pack.name = "space-station-starter-pack"
space_station_starter_pack.icons = {
  {
    icon = space_station_starter_pack.icon,
    icon_size = space_station_starter_pack.icon_size,
    tint = {r=1,g=0,b=0.8}
  },
}
space_station_starter_pack.tiles = make_tile_area({{-20, -20}, {19, 19}}, "space-platform-foundation")
space_station_starter_pack.initial_items = nil
space_station_starter_pack.create_electric_network = false
space_station_starter_pack.trigger = nil

-- Starter space platform hub
local starter_space_station_hub = table.deepcopy(data.raw["space-platform-hub"]["space-platform-hub"])
starter_space_station_hub.name = "starter-space-station-hub"

data:extend({
    space_station_starter_pack,
    starter_space_station_hub
})