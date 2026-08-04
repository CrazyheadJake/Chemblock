-- local solar_heater = table.deepcopy(data.raw["solar-panel"]["solar-panel"])
local solar_heater = {
    type = "reactor",
    name = "solar-heater",
    icons = {
        {
        icon = data.raw["solar-panel"]["solar-panel"].icon,
        icon_size = data.raw["solar-panel"]["solar-panel"].icon_size,
        tint = {r=1,g=0.4,b=0}
        }
    },
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "solar-heater"},
    max_health = 200,
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_source = {
        type = "void",
    },
    consumption = "1MW",
    heat_buffer = {
        max_temperature = 300,
        specific_heat = "10kJ",
        max_transfer = "1MW",
        connections = {
            {
                position = {0, 1},
                direction = defines.direction.south
            },
            {
                position = {0, -1},
                direction = defines.direction.north
            }
        }
    },
    picture = table.deepcopy(data.raw["solar-panel"]["solar-panel"].picture)
}
for _, layer in pairs(solar_heater.picture.layers) do
    layer.tint = {r=1,g=0.4,b=0}
end

data:extend(
    {
        solar_heater,
    }
)