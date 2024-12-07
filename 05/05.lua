package.path = package.path .. ";../?.lua"
local std = require("std.std")

local
  part1,
  part2,
  parse_data,
  set_dict,
  analyze_list,
  analyze_list_and_correct

local function main()

  local data = std.file.read_lines("data.txt")
  local rules, lists = table.unpack(parse_data(data))
  local nums = set_dict(rules)

  local answer1 = part1(lists, nums)
  print("Parte 1: ", answer1)
  local answer2 = part2(lists, nums)
  print("Parte 2:", answer2)

end

part1 = function(lists, nums)
  local count = 0

  for i=1, #lists do
    count = count + tonumber(analyze_list(lists[i], nums))
  end
  return count
end

part2 = function(lists, nums)
  local count = 0

  for i=1, #lists do
    count = count + tonumber(analyze_list_and_correct(lists[i], nums))
  end

  return count
end

local function find_elements(elements, list, index)
  local element = true
  for i=1, index do
    element = std.array.has_element(elements, list[i])
    if not element then break end
  end
  return element
end

analyze_list = function(list, nums)
  for i=2, #list do
    local elements = nums[list[i]]
    if elements then
      if not find_elements(elements, list, i - 1) then return 0 end
    else return 0 end
  end
  return list[(#list + 1)/2]
end

local function get_index(result, str)
  if not result then
    result = std.string.split(str, ",")
    if result then return 2, result end
    return 0, nil
  end
  return 1, result
end

parse_data = function(str)
  local data = {{}, {}}
  local index = 0
  for i=1, #str do
    local result = std.string.split(str[i], "|")
    index, result = get_index(result, str[i])
    if result then
      table.insert(data[index], result)
    end
  end
  return data
end

set_dict = function(r)
  local nums = {}
  for i=1, #r do
    local rule = r[i]
    if not nums[rule[2]] then nums[rule[2]] = {} end
    table.insert(nums[rule[2]], rule[1])
  end
  return nums
end

local function correct_update(list, nums, index)
  if index == 1 then return end
  while true do
    local elements = nums[list[index]]
    if not find_elements(elements, list, index - 1) then
      list[index], list[index - 1] = std.swap(list[index], list[index - 1])
      correct_update(list, nums, index - 1)
    end
    if index == #list then return end
    index = index + 1
  end
end

analyze_list_and_correct = function(list, nums)
  for i=2, #list do
    local elements = nums[list[i]]
    if not find_elements(elements, list, i - 1) then
      correct_update(list, nums, 2)
      return list[(#list + 1)/2]
    end
  end
  return 0
end

main()
