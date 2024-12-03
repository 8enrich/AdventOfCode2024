package.path = package.path .. ";../?.lua"
local std = require("std.std")
local read_data = require("read_data")

local function get_muls(memory)
  local muls = {}
  for str in string.gmatch(memory, "mul%(%d+,%d+%)") do
    table.insert(muls, str)
  end
  return muls
end

local function calculate_muls(muls)
  local result = 0
  for _,str in ipairs(muls) do
    local product = 1
    for mul in str:gmatch("%d+") do
      product = product * tonumber(mul)
    end
    result = result + product
  end
  return result
end

local function get_do(memory)
  local test = {}
  for str in memory:gmatch(".don't%(%).do%(%)") do
    table.insert(test, str)
  end
  return test
end

local memory = "Adon't()Bdon't()Cdon't()Ddo()Edo()Fdo()Gdon't()Hdo()I"--read_data.get_memory()
local muls_valids = get_do(memory)
--print(muls_valids)
--local muls = get_muls(muls_valids)
--local result = calculate_muls(muls)
--print(result)
