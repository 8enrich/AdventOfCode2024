
local read_data = require("read_data")
local level_04 = require("04")

local function columns(value, s, len_line, word_len)
  return level_04.take_some(value, s, len_line, word_len)
end

local function lines(value, s, len_line, word_len)
  if (value%len_line) + word_len - 1 > len_line then return "" end
  return level_04.take_some(value, s, 1, word_len)
end

local function divide_puzzle(puzzle, len_line)
  local t = {}
  local f = {level_04.diagonal_1, level_04.diagonal_2, columns, lines}
  for i=1, #puzzle do
    for j=1, #f do
      table.insert(t, f[j](i, puzzle, len_line, 4))
    end
  end
  return t
end

local function count_xmas(t)
  local count = 0

  for i=1, #t do
    if t[i] == "XMAS" or t[i] == "SAMX" then
      count = count + 1
    end
  end
  return count
end

local puzzle, len_line = read_data.get_puzzle()
local divided_puzzle = divide_puzzle(puzzle, len_line)
local count = count_xmas(divided_puzzle)

print(count)
