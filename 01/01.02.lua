

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

local function get_similarity_score(lista1, lista2)
  local score

  local values_saved = {}

  local similarity_score = 0

  for _, v in ipairs(lista1) do
    score = set_score(values_saved, v, lista2)
    if score ~= 0 then
      similarity_score = similarity_score + v * score
      values_saved[v] = score
    end
  end
  return similarity_score
end

local read_data = require("read_data")

local lista1, lista2 = read_data.get_lists_from_file()

local similarity_score = get_similarity_score(lista1, lista2)

print(similarity_score)
