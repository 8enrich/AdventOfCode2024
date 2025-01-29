
local string = require("std.string")
local array = require("std.array")
local file = require("std.file")
local dict = require("std.dict")
local set = require("std.set")

local function swap(a, b)
  return b, a
end

local function map(arr, f)
  if #arr == 0 then return {} end
  local t = {f(arr[1])};
  return array.add(map(array.slice(arr, 2, #arr), f), t)
end

local function filter(arr, f)
  if #arr == 0 then return {} end
  local t = {}
  if f(arr[1]) then table.insert(t, arr[1]) end
  return array.add(filter(array.slice(arr, 2, #arr), f), t)
end

local function reduce(arr, f)
  local result = nil
  for _, v in ipairs(arr) do
    if result == nil then result = v
    else result = f(v, result) end
  end
  return result
end

local function for_each(arr, f)
  if #arr == 0 then return end
  f(arr[1])
  return for_each(array.slice(arr, 2, #arr), f)
end

local function flat(arr)
  if #arr == 0 then return {} end
  return array.add(flat(array.slice(arr, 2, #arr)), {table.unpack(arr[1])})
end

local function flat_map(arr, f)
  return map(flat(arr), f)
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

local function enum(element)
  local iters = {
    ["table"] = array.iter,
    ["string"] = string.iter
  }
  local iter = iters[type(element)](element)
  local i = 0
  return function()
    local item = iter()
    i = i + 1
    if item then
      return i, item
    end
  end
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
  for_each = for_each,
  flat = flat,
  flat_map = flat_map,
  bin = bin,
  bin_digits = bin_digits,
  enum = enum
}
