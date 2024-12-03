
package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function get_lists_from_file()
  local lines, err = std.file.read_lines("data.txt")

  if err then error(err) end

  local lista1, lista2 = {}, {}

  for _,line in ipairs(lines) do
    local value1, value2 = table.unpack(std.string.split(line, "   "))
    table.insert(lista1, tonumber(value1))
    table.insert(lista2, tonumber(value2))
  end

  return lista1, lista2
end

return {
  get_lists_from_file = get_lists_from_file
}
