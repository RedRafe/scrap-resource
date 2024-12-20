function scrap_recipe()
  return settings.startup['sr_scrap_recycling'].value
end

local resource_autoplace = require('__core__/lualib/resource-autoplace')
--resource_autoplace.initialize_patch_set('scrap', true)

data:extend({
  -- Resource
  {
    type = 'resource',
    name = 'scrap',
    icon = '__scrap-resource__/graphics/hr-icon-scrap.png',
    icon_mipmaps = 1,
    icon_size = 159,
    flags = { 'placeable-neutral' },
    order = 'a-b-a',
    subgroup = 'raw-resource',
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      hardness = 2,
      mining_particle = 'stone-particle',
      mining_time = 3,
      results =
      {
        { type = 'item', amount = 1, probability = 0.02, name = 'processing-unit',       },
        { type = 'item', amount = 1, probability = 0.03, name = 'advanced-circuit',      },
        { type = 'item', amount = 1, probability = 0.01, name = 'low-density-structure', },
        { type = 'item', amount = 1, probability = 0.07, name = 'solid-fuel',            },
        { type = 'item', amount = 1, probability = 0.02, name = 'steel-plate',           },
        { type = 'item', amount = 1, probability = 0.06, name = 'concrete',              },
        { type = 'item', amount = 1, probability = 0.02, name = 'battery',               },
        { type = 'item', amount = 1, probability = 0.05, name = 'crude-oil-barrel',      },
        { type = 'item', amount = 1, probability = 0.05, name = 'stone',                 },
        { type = 'item', amount = 1, probability = 0.01, name = 'uranium-ore',           },
        { type = 'item', amount = 1, probability = 0.14, name = 'iron-gear-wheel',       },
        { type = 'item', amount = 1, probability = 0.02, name = 'copper-cable',          },
      }
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings({
      name = 'scrap',
      order = 'b',
      base_density = 6.0,
      base_spots_per_km2 = 1.25,
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 1.10,
      candidate_spot_count = 22,
      default_enabled= true,
    }),
    stage_counts = {1},
    stages = { 
      sheet = {
        filename = '__scrap-resource__/graphics/hd-scrap.png',
        priority = 'extra-high',
        size = 128,
        variation_count = 1,
        frame_count = 64,
        line_length = 8,
        scale = 0.5,
      }
    },
    mining_visualisation_tint = { 51, 51, 51 },
    map_color = { 51, 51, 51 }
  },
  -- Autoplace control
  {
    type = 'autoplace-control',
    name = 'scrap',
    localised_name = { '', '[entity=scrap] ', { 'autoplace-control-names.scrap' } },
    order= 'j-a',
    richness = true,
    category = 'resource'
  }
})

data.raw.planet.nauvis.map_gen_settings.autoplace_controls.scrap = {}
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings.scrap = {}

se_core_fragment_resources = se_core_fragment_resources or {}
se_core_fragment_resources['scrap'] = { multiplier = 0 }

if scrap_recipe() then
  local scrap = data.raw.resource.scrap

  data:extend({
    -- Item
    {
      name = 'scrap',
      type = 'item',
      icon = '__scrap-resource__/graphics/hr-icon-scrap.png',
      icon_mipmaps = 1,
      icon_size = 159,
      order='g[scrap]',
      subgroup = 'raw-resource',
      stack_size = 50,
    },
    -- Recipe
    {
      name = 'scrap-recycling',
      type = 'recipe',
      enabled = true,
      ingredients = {{ 'scrap', 1 }},
      results = table.deepcopy(scrap.minable.results),
      icon = '__scrap-resource__/graphics/hr-icon-scrap.png',
      icon_mipmaps = 1,
      icon_size = 159,
      category = 'smelting',
      energy_required = 3.2,
      main_product = '',
      subgroup = 'raw-resource',
    }
  })

  scrap.minable.results = {{ name = 'scrap', amount = 1 }}
end
