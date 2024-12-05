package.path = package.path .. ";../?.lua"

local read_data = require("read_data")
local std = require("std.std")
local level_05 = require("05")

local example = [[47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
]]

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
  if index == 0 then return end
  while true do
    local elements = nums[list[index]]
    if not find_elements(elements, list, index - 1) then
      local temp = list[index]
      list[index] = list[index - 1]
      list[index - 1] = temp
      correct_update(list, nums, index - 1)
      std.array.print_arr(list)
    end
    index = index + 1
    if index == #list then return end
  end
end

local function analise_list(list, nums)
  for i=2, #list do
    local elements = nums[list[i]]
    if not find_elements(elements, list, i - 1) then
      std.array.print_arr(list)
      correct_update(list, nums, 2)
      std.array.print_arr(list)
      return list[(#list + 1)/2]
    end
  end
  return 0
end

local data = read_data.get()
local rules, lists = level_05.parse_data(example)
local nums = level_05.set_dict(rules)

std.array.print_arr(lists)
std.dict.print(nums)

local count = 0

for i=1, #lists do
  count = count + tonumber(analise_list(lists[i], nums))
end

print(count)

