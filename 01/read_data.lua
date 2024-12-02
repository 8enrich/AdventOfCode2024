
package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function get_lists_from_file()
  local file = io.open("data.txt", "r")

  if file == nil then return nil, nil, error("Arquivo não encontrado.") end

  local lista1, lista2 = {}, {}

  for line in file:lines() do
    local value1, value2 = table.unpack(std.string.split(line, "   "))
    table.insert(lista1, tonumber(value1))
    table.insert(lista2, tonumber(value2))
  end
  file:close()

  return lista1, lista2, nil
end

return {
  get_lists_from_file = get_lists_from_file
}
