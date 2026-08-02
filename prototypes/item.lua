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

local spaceStationStartPack = table.deepcopy(data.raw["space-platform-starter-pack"]["space-platform-starter-pack"]) --[[@as SpacePlatformStarterPackPrototype]]
spaceStationStartPack.name = "space-station-starter-pack"
spaceStationStartPack.icons = {
    {
    icon = spaceStationStartPack.icon,
    icon_size = spaceStationStartPack.icon_size,
    tint = {r=1,g=0,b=1,a=0.3}
  },
}
spaceStationStartPack.tiles = make_tile_area({{-20, -20}, {19, 19}}, "space-platform-foundation")
spaceStationStartPack.initial_items = nil
spaceStationStartPack.create_electric_network = false

data:extend(
    {
        spaceStationStartPack
    }
)