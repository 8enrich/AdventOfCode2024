
local function get_lowest(lista)
  local index = 1
  for i=2, #lista do
    if lista[index] > lista[i] then index = i end
  end
  return table.remove(lista, index)
end

local function abs(x)
  if x < 0 then x = x * -1 end
  return x
end

local function get_distance_from_lists(lista1, lista2)
  local distance = 0
  while #lista1 > 0 and #lista2 > 0 do
    distance = distance + abs(get_lowest(lista1) - get_lowest(lista2))
  end
  return distance
end

local read_data = require("read_data")

local success, value = pcall(read_data.get_lists_from_file)

if not success then error(value) end

local lista1, lista2 = value.lista1, value.lista2

local distance = get_distance_from_lists(lista1, lista2)

print(distance)
