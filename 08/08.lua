package.path = package.path .. ";../?.lua"
local std = require("std.std")

local
  part1,
  part2,
  find_antenas,
  count_antinodes,
  verify_antinode,
  get_antinodes_pos,
  get_pos,
  get_antinodes,
  count_antinodes_with_harmonica,
  count_antinodes_type,
  get_antinodes_with_harmonica,
  insert_at_antinodes

local function main()

  local data = std.file.read_lines("example.txt")
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
      local antinode1, antinode2 = table.unpack(get_antinodes_pos(pos[i], pos[j]))
      if verify_antinode(antinode1, data) then
        std.set.add(antinodes, antinode1)
      end
      if verify_antinode(antinode2, data) then
        std.set.add(antinodes, antinode2)
      end
    end
  end
end

verify_antinode = function (antinode, data)
  local x, y = table.unpack(antinode)
  return x > 0 and x <= #data and y > 0 and y <= #data[1]
end

get_antinodes_pos = function (pos1, pos2)
  local distance = {math.abs(pos1[1] - pos2[1]), math.abs(pos1[2] - pos2[2])}
  return get_pos(distance, pos1, pos2)
end

get_pos = function (distance, pos1, pos2)
  local x, y = table.unpack(distance)
  local x1, y1 = table.unpack(pos1)
  local x2, y2 = table.unpack(pos2)
  local distances = {y1 > y2, y1 < y2, true}
  local positions = {
  {{x1 - x, y1 + y}, {x2 + x, y2 - y}},
  {{x1 - x, y1 - y}, {x2 + x, y2 + y}},
  {{0, 0}, {0, 0}}}
  for i=1, #distances do
    if distances[i] then
      return positions[i]
    end
  end
end

count_antinodes_with_harmonica = function (antenas, data)
  return count_antinodes_type(antenas, data, get_antinodes_with_harmonica)
end

get_antinodes_with_harmonica = function(antinodes, pos, data)
  for i=1, #pos do
    for j= i + 1, #pos do
      insert_at_antinodes(antinodes, data, pos[i], pos[j])
    end
  end
end

local function t1(antinodes, data, pos1, antinode1)
  local antinode2
  while verify_antinode(antinode1, data) do
    std.set.add(antinodes, antinode1)
    local temp = antinode1
    antinode1, antinode2 = table.unpack(get_antinodes_pos(antinode1, pos1))
    pos1 = temp
  end
end

local function t2(antinodes, data, pos2, antinode2)
  local antinode1
  while verify_antinode(antinode2, data) do
    std.set.add(antinodes, antinode2)
    local temp = antinode2
    antinode1, antinode2 = table.unpack(get_antinodes_pos(antinode2, pos2))
    pos2 = temp
  end
end

local function draw_map(antinodes, data)
  for i=1, #data do
    for j=1, #data[i] do
      local char = "."
      if std.array.has_element(antinodes, {i, j}) then
        char = "#"
      end
      io.write(char)
    end
    io.write("\n")
  end
  print()
end

insert_at_antinodes = function(antinodes, data, pos1, pos2)
  local antinode1, antinode2 = table.unpack(get_antinodes_pos(pos1, pos2))
  t1(antinodes, data, pos1, antinode1)
  t2(antinodes, data, pos2, antinode2)
  draw_map(antinodes, data)
end

main()
