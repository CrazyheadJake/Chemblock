local steam_furnace = table.deepcopy(data.raw.furnace["stone-furnace"])
steam_furnace.name = "steam-furnace"
steam_furnace.icons = {
    {
    icon = steam_furnace.icon,
    icon_size = steam_furnace.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
steam_furnace.energy_source = {
  type = "fluid",
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 200,
    pipe_covers = pipecoverspictures(),
    -- render_layer = "higher-object-above",
    pipe_connections =
    {
      {flow_direction = "input-output", direction = defines.direction.north, position = {-0.5, -0.5}},
      {flow_direction = "input-output", direction = defines.direction.south, position = {0.5, 0.5}},
    },
  },
  burns_fluid = true,        
  effectivity = 1,
  maximum_temperature = 165,  -- same cap the vanilla steam engine uses
}

steam_furnace.minable.result = "steam-furnace"
steam_furnace.surface_conditions = {}
steam_furnace.use_mirroring = true

local steam_crusher = table.deepcopy(data.raw["assembling-machine"]["crusher"])
steam_crusher.name = "steam-crusher"
steam_crusher.icons = {
    {
    icon = steam_crusher.icon,
    icon_size = steam_crusher.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
steam_crusher.energy_source = {
  type = "fluid",
  fluid_box = {
    production_type = "input-output",
    filter = "steam",
    volume = 200,
    pipe_covers = pipecoverspictures(),
    -- render_layer = "higher-object-above",
    pipe_connections =
    {
      {flow_direction = "input", direction = defines.direction.west, position = {-0.5, 0}},
    },
  },
  burns_fluid = true,        
  effectivity = 1,
  maximum_temperature = 165,  -- same cap the vanilla steam engine uses
}
steam_crusher.minable.result = "steam-crusher"
steam_crusher.surface_conditions = {}
steam_crusher.use_mirroring = true

local steam_asteroid_collector= table.deepcopy(data.raw["asteroid-collector"]["asteroid-collector"])
steam_asteroid_collector.name = "steam-asteroid-collector"
steam_asteroid_collector.icons = {
    {
    icon = steam_asteroid_collector.icon,
    icon_size = steam_asteroid_collector.icon_size,
    tint = {r=0.6,g=0.6,b=0.6}
  },
}
-- AsteroidCollectorPrototype only accepts ElectricEnergySource or
-- VoidEnergySource -- no fluid option, and no fluid_box on the prototype at all.
-- Void keeps it off the electric system entirely: no network to join, and no
-- electricity line in the tooltip. Steam is enforced by scripts/steam_collector,
-- which drains the hidden tank below and flips disabled_by_script.
steam_asteroid_collector.energy_source = {type = "void"}
steam_asteroid_collector.minable.result = "steam-asteroid-collector"

-- Steam is billed by watching the output inventory grow, so anything else that
-- puts items in looks like a collection. Inserting into a collector is
-- meaningless anyway, so block it outright rather than trying to detect it.
-- Note this only stops inserters and loaders -- players are handled separately
-- in scripts/steam_collector, since no flag can block manual insertion.
steam_asteroid_collector.flags = steam_asteroid_collector.flags or {}
table.insert(steam_asteroid_collector.flags, "no-automated-item-insertion")

-- A category with no recipes in it, so the buffer below can satisfy the required
-- crafting_categories without ever being able to craft anything.
local inert_category = {
  type = "recipe-category",
  name = "chemblock-inert",
}

-- The steam buffer the player pipes into. Invisible, but its pipe connection and
-- covers still render, so the connection point is visible.
--
-- The steam arrives as *fuel*, not as a recipe ingredient. A crafting machine's
-- fluid_boxes are ingredient boxes, and a machine only accepts a fluid its
-- current recipe asks for -- with no recipe it accepts nothing at all. A fluid
-- energy_source has no such condition, which is how steam_furnace and
-- steam_crusher above work, and it still takes flow_direction for one-way flow
-- (pipeline entities -- pipe, pipe-to-ground, storage-tank -- reject that).
-- Being fluid-powered also means no electric interface, so it cannot join a
-- network. Nothing is ever crafted here, so the "fuel" is never actually burned;
-- scripts/steam_collector drains this box directly.
local collector_tank = {
  type = "assembling-machine",
  name = "steam-asteroid-collector-tank",
  flags = {
    "placeable-off-grid", "not-on-map", "not-deconstructable", "not-blueprintable",
    "no-copy-paste", "not-selectable-in-game", "not-repairable", "not-upgradable",
    -- Without these, inserters aimed at the collector hit this instead: it sits
    -- on the same tiles and, being a crafting machine, has inventories they
    -- consider valid targets. It is also what draws the stray 1x1 interaction
    -- box in the middle of the collector when holding an inserter.
    "no-automated-item-removal", "no-automated-item-insertion",
  },
  crafting_categories = {inert_category.name},
  crafting_speed = 1,
  energy_usage = "1W",
  -- Empty layers means it collides with nothing, but the box still has to be
  -- real: pipe connection positions must lie inside the bounding box.
  collision_mask = {layers = {}},
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  energy_source = {
    type = "fluid",
    burns_fluid = true,
    effectivity = 1,
    maximum_temperature = 165,
    fluid_box = {
      production_type = "input",
      filter = "steam",
      volume = 200,
      pipe_covers = pipecoverspictures(),
      pipe_connections = {
        -- y = 1 is the centre of the southern tile row of a 3x3, so this lands
        -- on the collector's south edge.
        {flow_direction = "input", direction = defines.direction.south, position = {0, 1}},
      },
    },
  },
}

data:extend({
    steam_furnace,
    steam_crusher,
    steam_asteroid_collector,
    inert_category,
    collector_tank,
})