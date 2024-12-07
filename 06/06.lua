package.path = package.path .. ";../?.lua"
local std = require("std.std")

local
  part1,
  part2,
  find_initial_pos,
  get_locals,
  get_loops_quantity

local function main()

  local data = std.file.read_lines("data.txt")
  local initial_pos = find_initial_pos(data)
  local answer1 = part1(data, initial_pos)
  print("Parte 1: ", #answer1)
  local answer2 = part2(data, initial_pos, answer1)
  print("Parte 2:", answer2)

end

part1 = function(data, initial_pos)
  local locals = get_locals(data, initial_pos)
  return locals
end

part2 = function(data, initial_pos, locals)
  get_loops_quantity(data, initial_pos, locals)
end

find_initial_pos = function(data)
  for i=1, #data do
    for j=1, #data[i] do
      if data[i]:sub(j, j) == "^" then return {i, j} end
    end
  end
end

local function out(x, y, line)
  return x > line or x < 1 or y > line or y < 1
end

get_locals = function(data, initial_pos)
  local pos = {
    {-1, 0},
    {0, 1},
    {1, 0},
    {0, -1}
  }
  local i = 1
  local step = pos[i]
  local locals = {}
  local x, y = table.unpack(initial_pos)
  while not out(x, y, #data[1]) do
    if data[x]:sub(y, y) == "#" then
      i = i%4 + 1
      x = x - step[1]
      y = y - step[2]
      step = pos[i]
    end
    if not std.array.has_element(locals, {x, y}) then table.insert(locals, {x, y}) end
    x = x + step[1]
    y = y + step[2]
  end
  return locals
end

local function find_loops(data, initial_pos, hashtag)
  local pos = {
    {-1, 0},
    {0, 1},
    {1, 0},
    {0, -1}
  }
  local i = 1
  local step = pos[i]
  local locals = {}
  local x, y = table.unpack(initial_pos)
  while not out(x, y, #data[1]) do
    if data[x]:sub(y, y) == "#" or x == hashtag[1] and y == hashtag[2] then
      i = i%4 + 1
      x = x - step[1]
      y = y - step[2]
      step = pos[i]
    end
    if not std.array.has_element(locals, {x, y, i}) then table.insert(locals, {x, y, i})
    else return 1 end
    x = x + step[1]
    y = y + step[2]
  end
  return 0
end

get_loops_quantity = function (data, initial_pos, locals)
  local count = 0
  for i=2, #locals do
    count = count + find_loops(data, initial_pos, locals[i])
  end
  return count
end

main()
