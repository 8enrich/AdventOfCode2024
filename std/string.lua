
local function split(str, delimiter)
  local result = {}
  str = str .. delimiter
  while true do
    local index = str:find(delimiter)
    if not index then break end
    local left = str:sub(1, index - 1)
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

local function repr(str)
  return "'" .. str .. "'"
end

local function to_str(element)
  if type(element) == "table" then
    local s = "{"
    for i=1, #element do
      if type(element[i]) == "table" then s = s .. "\n   " end
      s = s .. to_str(element[i])
      if i ~= #element then s = s .. ", " end
    end
    if type(element[#element]) == "table" then s = s.. "\n" end
    return s .. "}"
  end
  if type(element) == "string" then
    return repr(element)
  end
  return tostring(element)
end

local function iter(str)
  local index = 1
  return function()
    if index <= #str then
      local char = str:sub(index, index)
      index = index + 1
      return char
    end
  end
end

return {
  split = split,
  replace = replace,
  repr = repr,
  to_str = to_str,
  iter = iter
}
