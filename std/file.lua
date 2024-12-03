
local function read_lines(filename)
  local file = io.open(filename, "r")

  if file == nil then return nil, error("Arquivo não encontrado.") end

  local lines = {}

  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()

  return lines, nil
end

return {
  read_lines = read_lines
}
