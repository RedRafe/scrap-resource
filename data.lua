local resource_autoplace = require("__core__/lualib/resource-autoplace")

data:extend({
  {
    type = "resource",
    name = "scrap",
    icon = "__base__/graphics/icons/wall-remnants.png",
    icon_mipmaps = 4,
    icon_size = 64,
    flags = {"placeable-neutral"},
    order="a-b-a",
    subgroup = "raw-resource",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      hardness = 2,
      mining_particle = "stone-particle",
      mining_time = 3,
      results =
      {
        { amount = 1, probability = 0.02, name = "processing-unit",       },
        { amount = 1, probability = 0.03, name = "advanced-circuit",      },
        { amount = 1, probability = 0.01, name = "low-density-structure", },
        { amount = 1, probability = 0.07, name = "solid-fuel",            },
        { amount = 1, probability = 0.02, name = "steel-plate",           },
        { amount = 1, probability = 0.06, name = "concrete",              },
        { amount = 1, probability = 0.02, name = "battery",               },
        { amount = 1, probability = 0.05, name = "crude-oil-barrel",      },
        { amount = 1, probability = 0.05, name = "stone",                 },
        { amount = 1, probability = 0.01, name = "uranium-238",           },
        { amount = 1, probability = 0.14, name = "iron-gear-wheel",       },
        { amount = 1, probability = 0.02, name = "copper-cable",          },
      }
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings(
      {
        name = "scrap",
        order = "d",
        base_density = 6.0,
        base_spots_per_km2 = 1.25,
        has_starting_area_placement = false,
        regular_rq_factor_multiplier = 1.10,
        candidate_spot_count = 22
      }),
    stage_counts = {1},
    stages =
      { 
        {
          filename = "__scrap-resource__/graphics/scrap.png",
          priority = "extra-high",
          size = 64,
          variation_count = 1,
          frame_count = 12,
        }
      },
    mining_visualisation_tint = {r = 0.814, g = 1.000, b = 0.499, a = 1.000},
    map_color = {0.7, 0, 0.7}
  },
  {
    type = "autoplace-control",
    name = "scrap",
    localised_name = { "", "[entity=scrap] ", { "autoplace-control-names.scrap" } },
    order= "j-a",
    richness = true,
    category = "resource"
  },
  {
    type = "noise-layer",
    name = "scrap"
  }
})