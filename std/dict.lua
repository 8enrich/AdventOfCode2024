
local array = require("std.array")

local function print(dict)
  local write = io.write
  write("{\n")
  local v
  local i = 1
  for k, element in pairs(dict) do
    write("  " .. tostring(k) .. ": ")
    if type(element) == "table" then
      v = "  " .. array.to_str(element) .. ", \n"
    else
      v = tostring(element) .. ", \n"
    end
    write(v)
    i = i + 1
  end
  write('\n}\n')
end

return {
  print = print
}
