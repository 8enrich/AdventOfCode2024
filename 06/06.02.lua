
local read_data = require("read_data")
local level_06 = require("06")
package.path = package.path .. ";../?.lua"
local std = require("std.std")


local example = [[
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
]]

local function test(data, hashtag)
  local line = data:find("\n")
  local steps = {-line, 1, line, -1}
  local actual = data:find("%^")
  local i = 1
  local next_s = actual + steps[i]
  local locals = {actual}
  local o = 0
  while not level_06.out(actual, line, i, #data) do
    if data:sub(next_s, next_s) == "#" or next_s == hashtag then i = i%4 + 1 end
    actual = actual + steps[i]
    std.set.add(locals, actual)
    next_s = actual + steps[i]
    o = o + 1
    if o > line * line * 4 then return 1 end
  end
  return 0
end

local function get_locals_with_loop(locals_visited, data)
  local count = 0
  for j=2, #locals_visited do
    print(j)
    count = count + test(data, locals_visited[j])
  end
  return count
end

local data = read_data.get()
local locals = level_06.get_locals(data)
local loops = get_locals_with_loop(locals, data)
print(loops)
