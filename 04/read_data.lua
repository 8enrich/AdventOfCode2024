package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function get_puzzle()

  local lines, err = std.file.read_lines("data.txt")

  if err then error(err) end

  local puzzle = ""
  local count = 0

  for _,line in ipairs(lines) do
    puzzle = puzzle .. line .. "\n"
    if count == 0 then count = #puzzle end
  end

  return puzzle, count
end

return {
  get_puzzle = get_puzzle
}
