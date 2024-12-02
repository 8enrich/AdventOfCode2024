
local function print_arr(array)
  local write = io.write
  write("{")
  for i=1, #array do
    local v = tostring(array[i])
    write(v)
    if i ~= #array then write(', ') end
  end
  write('}\n')
end

return {
  print_arr = print_arr
}
