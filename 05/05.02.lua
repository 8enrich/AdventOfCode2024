package.path = package.path .. ";../?.lua"

local read_data = require("read_data")
local std = require("std.std")
local level_05 = require("05")

local function find_elements(elements, list, index)
  if not elements then return false end
  local element = true
  for i=1, index do
    element = std.array.has_element(elements, list[i])
    if not element then break end
  end
  return element
end

local function correct_update(list, nums, index)
  if index == 1 then return end
  while true do
    local elements = nums[list[index]]
    if not find_elements(elements, list, index - 1) then
      local temp = list[index]
      list[index] = list[index - 1]
      list[index - 1] = temp
      correct_update(list, nums, index - 1)
    end
    if index == #list then return end
    index = index + 1
  end
end

local function analise_list(list, nums)
  for i=2, #list do
    local elements = nums[list[i]]
    if not find_elements(elements, list, i - 1) then
      correct_update(list, nums, 2)
      return list[(#list + 1)/2]
    end
  end
  return 0
end

local data = read_data.get()
local rules, lists = level_05.parse_data(data)
local nums = level_05.set_dict(rules)

local count = 0

for i=1, #lists do
  count = count + tonumber(analise_list(lists[i], nums))
end

print(count)
