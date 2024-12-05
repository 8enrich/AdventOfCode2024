
local function to_str(array)
  local str = "{"
  for i=1, #array do
    str = str .. tostring(array[i])
    if i ~= #array then str = str .. ", " end
  end
  return str .. "}"
end

local function print_arr(array)
  local write = io.write
  write("{")
  local v
  local i = 1
  for _, element in pairs(array) do
    if type(element) == "table" then
      v = "\n  " .. to_str(element)
    else
      v = tostring(element)
    end
    write(v)
    if i ~= #array then write(', ') end
    i = i + 1
  end
  write('}\n')
end

local function has_element(list, element)
  for i=1, #list do
    if list[i] == element then return true end
  end
  return false
end


return {
  print_arr = print_arr,
  to_str = to_str,
  has_element = has_element
}
