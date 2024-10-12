if mods['space-exploration'] then
  -- Remove scrap fragments
  data.raw.item.scrap = nil
  data.raw.recipe['scrap-recycling'] = nil

  -- Remove K2 crusher void recipe
  if mods['Krastorio2'] then
    data.raw.recipe['kr-vc-scrap'] = nil
  end

  -- Update resource
  local resource = data.raw.resource.scrap
  if resource and resource.minable then
    -- result
    if resource.minable.result == 'scrap' then
      resource.minable.result = 'se-scrap'
    end
    -- results
    for _, result in pairs(resource.minable.results or {}) do
      if result.name == 'scrap' then
        result.name = 'se-scrap'
      end
    end
  end

  -- Remove scrap from omni core fragments
  for i, result in pairs(data.raw.recipe['se-core-fragment-omni'].results) do
    if result.name == 'scrap' then
      table.remove(data.raw.recipe['se-core-fragment-omni'].results, i)
    end
  end
else
  if mods['Krastorio2'] then
    local k2_recipe = data.raw.recipe['kr-vc-scrap']
    if k2_recipe then
      k2_recipe.subgroup = 'raw-material'
      k2_recipe.results = table.deepcopy(data.raw.recipe['scrap-recycling'].results)

      local crusher = data.raw.furnace['kr-crusher']
      crusher.result_inventory_size = math.max(crusher.result_inventory_size, table_size(k2_recipe.results))
    end
  end
end

if mods['janky-quality'] and scrap_recipe() then
  data.raw.recipe['scrap-recycling'].category = 'jq-recycling'
end