
local read_data = require("read_data")
local level_04 = require("04")

local function check_mas(str)
  if str == "MAS" or str == "SAM" then
    return str
  end
  return nil
end

local function divide_puzzle(puzzle, len_line)
  local t = {}
  for i=1, #puzzle do
    local str = check_mas(level_04.diagonal_1(i, puzzle, len_line, 3))
    if str then str = check_mas(level_04.diagonal_2(i + 2, puzzle, len_line, 3)) end
    if str then table.insert(t, str) end
  end
  return t
end

local puzzle, len_line = read_data.get_puzzle()
local divided_puzzle = divide_puzzle(puzzle, len_line)

print(#divided_puzzle)
