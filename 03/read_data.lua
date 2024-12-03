package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function get_memory()

  local lines, err = std.file.read_lines("data.txt")

  if err then error(err) end

  local memory = ""

  for _,line in ipairs(lines) do
    memory = memory .. line
  end

  return memory
end

return {
  get_memory = get_memory
}
