
package.path = package.path .. ";../?.lua"

local std = require("std.std")
local read_data = require("read_data")
local level_03 = require("03")

local function get_valid_memory(memory)
  for str in memory:gmatch("don't%(%).-do%(%)") do
    memory = std.string.replace(memory, str, "")
  end
  return memory
end


local memory = read_data.get_memory()
memory = get_valid_memory(memory)

local muls = level_03.get_muls(memory)
local result = level_03.calculate_muls(muls)
print(result)
