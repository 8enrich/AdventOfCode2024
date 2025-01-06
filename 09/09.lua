package.path = package.path .. ";../?.lua"
local std = require("std.std")

local
  part1,
  part2

local function main()

  local data = std.file.read_lines("data.txt")
  local answer1 = part1(data)
  print("Parte 1: ", answer1)
  local answer2 = part2(data)
  print("Parte 2:", answer2)

end

part1 = function(data) return 0 end

part2 = function(data) return 0 end

main()
