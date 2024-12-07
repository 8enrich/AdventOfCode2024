
local str = require("std.string")

local function iter(array)
  local index = 1
  return function()
    if index <= #array then
      local item = array[index]
      index = index + 1
      return item
    end
  end
end

local function to_str(array)
  local s = "{"
  for i=1, #array do
    if type(array[i]) == "table" then s = s .. "\n   " end
    s = s .. str.to_str(array[i])
    if i ~= #array then s = s .. ", " end
  end
  if type(array[#array]) == "table" then s = s.. "\n" end
  return s .. "}"
end

local function print(array)
  _G.print(to_str(array))
end

local function compare(arr1, arr2)
  if not arr1 or not arr2 or #arr1 ~= #arr2 then return false end
  for i=1, #arr1 do
    if arr1[i] ~= arr2[i] then return false end
  end
  return true
end

local function has_element(arr, element)
  if type(element) == "table" then
    for i=1, #arr do
      if compare(arr[i], element) then return true end
    end
    return false
  end
  for i=1, #arr do
    if arr[i] == element then return true end
  end
  return false
end

return {
  print = print,
  to_str = to_str,
  has_element = has_element,
  iter = iter,
  compare = compare
}
