package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function get()

  local lines, err = std.file.read_lines("data.txt")

  if err then error(err) end

  local data = ""

  for _,line in ipairs(lines) do
    data = data .. line .. "\n"
  end

  return data
end

return {
  get = get
}
