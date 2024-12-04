
local function split(str, delimiter)
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
      table.insert(result, match)
    end
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
