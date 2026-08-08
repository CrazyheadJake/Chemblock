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


-- Cupric asteroid chunk.
--
-- This is an "asteroid" (AsteroidPrototype), not an "asteroid-chunk":
--   * AsteroidChunkPrototype descends straight from Prototype, so it has no
--     selection_box and can never be hovered or hand-mined -- only collected by
--     an asteroid collector.
--   * AsteroidPrototype descends from EntityWithOwnerPrototype, so it inherits
--     selection_box / collision_box / minable / max_health from EntityPrototype,
--     and the engine knows how to drift it through space (asteroids accept a
--     `velocity` on create_entity; plain entities do not).
-- asteroid_spawn_definitions also only accepts these two types, so an ordinary
-- simple-entity cannot be spawned in space at all.
local resource_asteroid = table.deepcopy(data.raw["asteroid"]["small-metallic-asteroid"])
local tint = {r=0, g=0, b=1}

resource_asteroid.name = "resource-asteroid"
resource_asteroid.icons = {
    {
        icon = resource_asteroid.icon,
        icon_size = resource_asteroid.icon_size,
        tint = tint,
    },
}

-- Borrow the real chunk's graphics so it reads as a chunk rather than a
-- small asteroid. Both prototypes use AsteroidGraphicsSet, so this is a
-- like-for-like swap.
resource_asteroid.graphics_set = table.deepcopy(resource_asteroid.graphics_set)
-- lights[2] is the slot vanilla itself overrides per asteroid type to give each
-- one its colour identity (metallic warm-brown, oxide teal). A flat `tint` on
-- the graphics_set textures is ignored by the asteroid material shader.
resource_asteroid.graphics_set.lights[2] = {color = tint, direction = {-1, -45, 0.1}}

-- The part chunks structurally cannot have.
resource_asteroid.minable = {
    mining_time = 0.2,
    mining_particle = "metallic-asteroid-chunk-particle-medium",
    results = {
        {type = "item", name = "copper-ore", amount_min = 4, amount_max=10},
        {type = "item", name = "iron-ore", amount_min = 4, amount_max=10},
        {type = "item", name = "stone", amount_min = 4, amount_max=10},
        {type = "item", name = "ice", amount_min = 10, amount_max=20},
    },
}
resource_asteroid.dying_trigger_effect[2] = nil

resource_asteroid.damage_per_hp = 0
resource_asteroid.custom_tooltip_fields = {
    {
        name = "Drops",
        value = {"entity-description.resource-asteroid-drops"}
    }
}

data:extend({
    cupric_asteroid_chunk,
    resource_asteroid,
})
