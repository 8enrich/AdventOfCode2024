package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function parse_data(example)
  local str = std.string.split(example, "\n")
  assert(str)
  local rules = {}
  local lists = {}
  for i=1, #str do
    local result = std.string.split(str[i], "|")
    if not result then
      result = std.string.split(str[i], ",")
      if result then
        table.insert(lists, result)
      end
    else
      table.insert(rules, result)
    end
  end
  return rules, lists
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
