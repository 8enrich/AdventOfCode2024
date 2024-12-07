
local string = require("std.string")
local array = require("std.array")
local file = require("std.file")
local dict = require("std.dict")
local set = require("std.set")

local function swap(a, b)
  return b, a
end

local function map(arr, f)
  local result = {}
  for _, v in ipairs(arr) do
    table.insert(result, f(v))
  end
  return result
end

local function filter(arr, f)
  local result = {}
  for _, v in ipairs(arr) do
    if f(v) then
      table.insert(result, v)
    end
  end
  return result
end

local function reduce(arr, f)
  local result = nil
  for _, v in ipairs(arr) do
    if result == nil then result = v
    else result = f(v, result) end
  end
  return result
end

local function bin(n)
  if n < 2 then return tostring(n) end
  return bin(math.floor(n / 2)) .. (n % 2)
end

local function bin_digits(n, d)
  local b = bin(n)
  while #b < d do
    b = "0" .. b
  end
  return b
end

return {
  string = string,
  array = array,
  file = file,
  dict = dict,
  set = set,
  swap = swap,
  map = map,
  filter = filter,
  reduce = reduce,
  bin = bin,
  bin_digits = bin_digits
}
