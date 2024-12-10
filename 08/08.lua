package.path = package.path .. ";../?.lua"
local std = require("std.std")

local
  part1,
  part2,
  find_antenas,
  count_antinodes,
  count_antinodes_type,
  get_antinodes,
  analyse_node,
  verify_antinode,
  count_antinodes_with_harmonica,
  get_antinodes_with_harmonica,
  analyse_node_with_harmonica

local function main()

  local data = std.file.read_lines("data.txt")
  local antenas = find_antenas(data)
  local answer1 = part1(antenas, data)
  print("Parte 1: ", answer1)
  local answer2 = part2(antenas, data)
  print("Parte 2:", answer2)

end

part1 = function(antenas, data)
  local count = count_antinodes(antenas, data)
  return count
end

part2 = function(antenas, data)
  local count = count_antinodes_with_harmonica(antenas, data)
  return count
end

find_antenas = function(data)
  local antenas = {}
  for i=1, #data do
    local j = 1
    for char in std.string.iter(data[i]) do
      if char ~= "." then
        if not antenas[char] then antenas[char] = {} end
        table.insert(antenas[char], {i, j})
      end
      j = j + 1
    end
  end
  return antenas
end

count_antinodes = function (antenas, data)
  return count_antinodes_type(antenas, data, get_antinodes)
end

count_antinodes_type = function(antenas, data, f)
  local antinodes = {}
  for _, pos in pairs(antenas) do
    f(antinodes, pos, data)
  end
  return #antinodes
end

get_antinodes = function(antinodes, pos, data)
  for i=1, #pos do
    for j= i + 1, #pos do
      analyse_node(pos[i], pos[j], antinodes, data)
      analyse_node(pos[j], pos[i], antinodes, data)
    end
  end
end

analyse_node = function(pos1, pos2, antinodes, data)
  local distance = std.array.sub(pos1, pos2)
  local antinode = std.array.sum(pos1, distance)
  if verify_antinode(antinode, data) then
    std.set.add(antinodes, antinode)
  end
end

verify_antinode = function (antinode, data)
  local x, y = table.unpack(antinode)
  return x > 0 and x <= #data and y > 0 and y <= #data[1]
end

count_antinodes_with_harmonica = function (antenas, data)
  return count_antinodes_type(antenas, data, get_antinodes_with_harmonica)
end

get_antinodes_with_harmonica = function(antinodes, pos, data)
  for i=1, #pos do
    for j=i + 1, #pos do
      analyse_node_with_harmonica(pos[i], pos[j], antinodes, data)
      analyse_node_with_harmonica(pos[j], pos[i], antinodes, data)
    end
  end
end

analyse_node_with_harmonica = function(pos1, pos2, antinodes, data)
  local minus_distance = std.array.sub(pos2, pos1)
  local antinode_left = std.array.sum(pos1, minus_distance)
  if verify_antinode(antinode_left, data) then
    std.set.add(antinodes, antinode_left)
  end
  local distance = std.array.sub(pos1, pos2)
  local antinode = std.array.sum(pos1, distance)
  local value = 1
  while verify_antinode(antinode, data) do
    std.set.add(antinodes, antinode)
    value = value + 1
    antinode = std.array.sum(pos1, std.array.mul(distance, value))
  end
end


main()
