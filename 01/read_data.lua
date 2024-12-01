
local function get_lists_from_file()
  local file = io.open("data.txt", "r")

  if file == nil then error("Arquivo não encontrado.") end

  local listas = {
    ["lista1"]= {},
    ["lista2"]= {}
  }

  local count = 0

  for line in file:lines() do
    for i in string.gmatch(line, "%S+") do
      if count % 2 == 0 then table.insert(listas.lista1, tonumber(i)) end
      if count % 2 == 1 then table.insert(listas.lista2, tonumber(i)) end
      count = count + 1
    end
  end
  file:close()

  return listas
end

return {
  get_lists_from_file = get_lists_from_file
}
