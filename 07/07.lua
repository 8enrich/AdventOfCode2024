package.path = package.path .. ";../?.lua"
local std = require("std.std")

local
  part1,
  part2,
  get_equations,
  can_solve_2_operators,
  can_solve_3_operators,
  get_result

local function main()

  local data = std.file.read_lines("data.txt")
  local equations = get_equations(data)
  local answer1 = part1(equations)
  print("Parte 1: ", answer1)
  local answer2 = part2(equations)
  print("Parte 2:", answer2)

end

part1 = function(equations)
  return get_result(equations, can_solve_2_operators)
end

part2 = function(equations)
  return get_result(equations, can_solve_3_operators)
end

get_result = function(equations, f)
  local result = 0
  for k, v in pairs(equations) do
    if f(k, v) then result = result + tonumber(k) end
  end
  return result
end

get_equations = function (data)
  local equations = {}
  for item in std.array.iter(data) do
    local splitted = std.string.split(item, ": ")
    assert(splitted)
    local result, all_values = table.unpack(splitted)
    local values = std.string.split(all_values, " ")
    equations[result] = values
  end
  return equations
end

local function solve(a, b, op)
  local operations = {
    ["0"]= "+",
    ["1"] = "*",
    ["2"] = "||"
  }
  if operations[op] == "+" then return a + tonumber(b) end
  if operations[op] == "*" then return a * tonumber(b) end
  if operations[op] == "||" then return tonumber(tostring(a) .. tostring(tonumber(b))) end
  return 0
end

local function base_3(n)
  if n < 3 then return tostring(n) end
  return base_3(math.floor(n / 3)) .. (n % 3)
end

local function base_3_digits(n, d)
  local v = base_3(n)
  while #v < d do
    v = "0" .. v
  end
  return v
end

local function get_possibilities(i, size, value)
  if value == 2 then return std.bin_digits(i, size) end
  return base_3_digits(i, size)
end

local function can_solve(result, values, operators)
  local possibilites = operators ^ (#values - 1)
  for i=0, possibilites - 1 do
    local operation = get_possibilities(i, #values - 1, operators)
    local value = tonumber(values[1])
    for j=2, #values do
      local op = operation:sub(1, 1)
      value = solve(value, values[j], op)
      operation = operation:sub(2, #operation)
    end
    if tonumber(result) == tonumber(value) then return true end
  end
  return false
end

can_solve_2_operators = function(result, values)
  return can_solve(result, values, 2)
end

can_solve_3_operators = function (result, values)
  return can_solve(result, values, 3)
end

main()
