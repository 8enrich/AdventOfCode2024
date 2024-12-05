
local function install()
  local filename = "dependecies.txt"
  local file = io.open(filename, "r")
  if not file then return error("Não foi possível abrir o arquivo " .. filename) end
  for dependecie in file:lines() do
    print("Installing " .. dependecie .. "...")
    os.execute("luarocks install " .. dependecie)
  end
  file:close()
end

install()
