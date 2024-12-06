
local string = require("std.string")
local array = require("std.array")
local file = require("std.file")
local dict = require("std.dict")

local function swap(a, b)
  return b, a
end

return {
  string = string,
  array = array,
  file = file,
  dict = dict,
  swap = swap
}
