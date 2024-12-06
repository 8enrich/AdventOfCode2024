package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function get_index(result, str)
  if not result then
    result = std.string.split(str, ",")
    if result then return 2, result end
    return 0, nil
  end
  return 1, result
end

local function parse_data(d)
  local str = std.string.split(d, "\n")
  assert(str)
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

local function set_dict(r)
  local nums = {}
  for i=1, #r do
    local rule = r[i]
    if not nums[rule[2]] then nums[rule[2]] = {} end
    table.insert(nums[rule[2]], rule[1])
  end
  return nums
end

return {
  parse_data = parse_data,
  set_dict = set_dict
}
