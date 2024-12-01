

local function value_ocorrences_in_list(value, lista)
  local count = 0
  for _, v in ipairs(lista) do
    if v == value then count = count + 1 end
  end
  return count
end

local function set_score(values_saved, v, lista2)
  for key, value in ipairs(values_saved) do
    if key == v then return value end
  end
  return value_ocorrences_in_list(v, lista2)
end

local read_data = require("read_data")

local success, value = pcall(read_data.get_lists_from_file)

if not success then error(value) end

local lista1, lista2 = value.lista1, value.lista2

local similarity_score = 0

local score

local values_saved = {}

for _, v in ipairs(lista1) do
  score = set_score(values_saved, v, lista2)
  if score ~= 0 then
    similarity_score = similarity_score + v * score
    values_saved[value] = score
  end
end

print(similarity_score)
