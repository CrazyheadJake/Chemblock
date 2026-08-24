local techs = {}

-- Add crushing trigger tech
techs.asteroid_crushing = {
  type = "technology",
  name = "asteroid-crushing",
  icon = "__base__/graphics/technology/electric-energy-acumulators.png",
  icon_size = 256,
  localised_name = { "technology-name.steam-crushing" },
  effects = {
    {
      type = "unlock-recipe",
      recipe = "cupric-asteroid-crushing"
    },
    {
      type = "unlock-recipe",
      recipe = "carbonic-asteroid-crushing"
    },
    {
      type = "unlock-recipe",
      recipe = "oxide-asteroid-crushing"
    },
    {
      type = "unlock-recipe",
      recipe = "metallic-asteroid-crushing"
    },
    {
      type = "unlock-recipe",
      recipe = "stone-crushing"
    },
  },
  research_trigger =
  {
    type = "build-entity",
    entity = "steam-crusher",
  },
  prerequisites = { "steam-power" }
}

-- Add basic electricity
techs.basic_electricity = {
  type = "technology",
  name = "basic-electricity",
  icon = "__base__/graphics/technology/electric-energy-acumulators.png",
  icon_size = 256,
  localised_name = { "technology-name.basic-electricity" },
  effects = {
    {
      type = "unlock-recipe",
      recipe = "iron-electric-pole"
    },
    {
      type = "unlock-recipe",
      recipe = "solar-heater"
    },
    {
      type = "unlock-recipe",
      recipe = "simple-heat-pipe"
    },
    {
      type = "unlock-recipe",
      recipe = "simple-heat-exchanger"
    },
    {
      type = "unlock-recipe",
      recipe = "steam-engine"
    },
  },
  unit = {
    count = 20,
    ingredients = {{"automation-science-pack", 1}},
    time = 15
  },
  prerequisites = { "automation-science-pack" }
}

for _, tech in pairs(techs) do
  data:extend({ tech })
end

-- Update first two trigger techs
data.raw.technology["steam-power"].research_trigger = {
  type = "craft-item",
  item = "iron-plate",
  count = 30,
}
data.raw.technology["steam-power"].effects = {
  {
    type = "unlock-recipe",
    recipe = "pipe"
  },
  {
    type = "unlock-recipe",
    recipe = "pipe-to-ground"
  },
  {
    type = "unlock-recipe",
    recipe = "steam-asteroid-collector"
  },
  {
    type = "unlock-recipe",
    recipe = "steam-crusher"
  },
  {
    type = "unlock-recipe",
    recipe = "steam-furnace"
  }
}

data.raw.technology["electronics"].research_trigger = {
  type = "craft-item",
  item = "copper-plate",
  count = 10,
}
data.raw.technology["electronics"].effects = {
  {
    type = "unlock-recipe",
    recipe = "copper-cable"
  },
  {
    type = "unlock-recipe",
    recipe = "steam-lab"
  }
}

data.raw.technology["automation-science-pack"].research_trigger =
{
  type = "craft-item",
  item = "steam-lab"
}

data.raw.technology["automation"].effects = {
  {
    type = "unlock-recipe",
    recipe = "steam-assembling-machine"
  }
}
