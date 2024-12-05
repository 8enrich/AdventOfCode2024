
local function split(str, delimiter)
  local result = {}
  str = str .. delimiter
  while true do
    local index = str:find(delimiter)
    if not index then break end
    local left = str:sub(1, index - #delimiter)
    table.insert(result, left)
    str = str:sub(index + #delimiter, #str)
  end
  if #result == 1 then return nil end
  return result
end

local function replace(str, old, new)
  local new_str = ""
  local i = 1
  while i <= #str do
    if str:sub(i, i + #old - 1) == old then
      new_str = new_str .. new
      i = i + #old
    else
      new_str = new_str .. str:sub(i, i)
      i = i + 1
    end
  end
  return new_str
end

return {
  split = split,
  replace = replace
}
