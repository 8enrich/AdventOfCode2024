package.path = package.path .. ";../?.lua"
local std = require("std.std")

local function out(actual, line, step_type, size)
  local verifications = {
    actual - line < 1,
    (actual%line) + 1 > line,
    actual + line > size,
    (actual%line) - 1 < 1,
  }
  return verifications[step_type]
end

local function get_locals(data)
  local line = data:find("\n")
  local steps = {-line, 1, line, -1}
  local actual = data:find("%^")
  local locals = {actual}
  local i = 1
  local next_s = 0
  while not out(actual, line, i, #data) do
    if data:sub(next_s, next_s) == "#" then i = i%4 + 1
    else actual = actual + steps[i] end
    std.set.add(locals, actual)
    next_s = actual + steps[i]
  end
  return locals
end

return {
  get_locals = get_locals,
  out = out
}
