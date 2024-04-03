local scrap = data.raw.resource.scrap

-- clean invalid results
if scrap and scrap.minable then
  local results = {}
  for _, entry in pairs(scrap.minable.results or {}) do
    if data.raw.item[entry.name] ~= nil then
      table.insert(results, entry)
    end
  end

  scrap.minable.result = nil
  scrap.minable.results = results
end

-- check # of output slots if recipe is enabled
if settings.startup['sr:scrap_recycling'].value then
  local recipe = data.raw.recipe['scrap-recycling']
  if recipe then
    local category = recipe and recipe.category
    local max_results = table_size((recipe or {}).results or {})

    for _, furnace in pairs(data.raw.furnace) do
      local upscale = false
      for _, cat in pairs(furnace.crafting_categories or {}) do
        upscale = upscale or (cat == category)
      end

      if upscale then
        furnace.result_inventory_size = max_results
      end
    end
  end
end
