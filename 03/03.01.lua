
local read_data = require("read_data")

local function get_muls(memory)
  local muls = {}
  for str in memory:gmatch("mul%(%d+,%d+%)") do
    table.insert(muls, str)
  end
  return muls
end

local function get_product(str)
  local product = 1
  for mul in str:gmatch("%d+") do
    product = product * tonumber(mul)
  end
  return product
end

local function calculate_muls(muls)
  local result = 0
  for _,str in ipairs(muls) do
    local product = get_product(str)
    result = result + product
  end
  return result
end

local memory = read_data.get_memory()
local muls = get_muls(memory)
local result = calculate_muls(muls)

print(result)
