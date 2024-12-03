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

  local lines, err = std.file.read_lines("data.txt")

  if err then error(err) end

  local reports = {}

  for _, line in ipairs(lines) do
    local level = int_list(std.string.split(line, " "))
    table.insert(reports, level)
  end

  return reports
end

return {
  get_reports = get_reports
}
