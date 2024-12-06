package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function get()
  local data = ""
  for l in std.array.iter(std.file.read_lines("data.txt")) do
    data = data .. l .. "\n"
  end
  return data
end

return {
  get = get
}
