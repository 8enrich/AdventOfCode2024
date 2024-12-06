
local str = require("std.string")

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

local function has_element(list, element)
  for i=1, #list do
    if list[i] == element then return true end
  end
  return false
end

return {
  print = print,
  to_str = to_str,
  has_element = has_element
}
