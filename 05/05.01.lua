package.path = package.path .. ";../?.lua"

local read_data = require("read_data")
local std = require("std.std")
local level_05 = require("05")

local function find_elements(elements, list, index)
  local element = true
  for i=1, index do
    element = std.array.has_element(elements, list[i])
    if not element then break end
  end
  return element
end

local function analise_list(list, nums)
  for i=2, #list do
    local elements = nums[list[i]]
    if elements then
      if not find_elements(elements, list, i - 1) then return 0 end
    else return 0 end
  end
  return list[(#list + 1)/2]
end

local count = 0

local data = read_data.get()
local rules, lists = table.unpack(level_05.parse_data(data))
local nums = level_05.set_dict(rules)

for i=1, #lists do
  count = count + tonumber(analise_list(lists[i], nums))
end

print(count)
