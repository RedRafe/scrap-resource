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