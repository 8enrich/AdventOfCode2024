
local array = require("std.array")

local function add(set, item)
  if not set or not array.has_element(set, item) then
    table.insert(set, item)
  end
end

return {
  add = add
}
