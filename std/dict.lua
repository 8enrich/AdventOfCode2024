
local str = require("std.string")

local function to_str(dict)
  local s = "{"
  for k, element in pairs(dict) do
    s = s .. "\n   " .. str.to_str(k) .. ": "
    s = s .. str.to_str(element) .. ", "
  end
  return s .. "\n}"
end

local function print(dict)
  _G.print(to_str(dict))
end

return {
  print = print,
  to_str = to_str
}
