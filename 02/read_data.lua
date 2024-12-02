package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function int_list(lista)
  local result = {}
  for i=1, #lista do
    table.insert(result, tonumber(lista[i]))
  end
  return result
end

local function get_reports()
  local file = io.open("data.txt", "r")

  if file == nil then return nil, error("Arquivo não encontrado.") end

  local reports = {}

  for line in file:lines() do
    local level = int_list(std.string.split(line, " "))
    table.insert(reports, level)
  end
  file:close()

  return reports, nil
end

return {
  get_reports = get_reports
}
