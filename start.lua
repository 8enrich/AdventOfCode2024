
local function get_files()
  local handle = io.popen('ls')
  if not handle then return nil, error("Não foi possível ler o diretório.") end
  local result = handle:read('*a')
  handle:close()
  return result, nil
end

local function create_files(today)
  os.execute("mkdir " .. today)
  local today_dir = today .. "/"
  os.execute("touch " .. today_dir .. today .. ".lua")
  os.execute("touch " .. today_dir .. today .. "." .. "01.lua")
  os.execute("touch " .. today_dir .. today .. "." .. "02.lua")
  os.execute("touch " .. today_dir .. "read_data.lua")
  os.execute("touch " .. today_dir .. "")
end

local function get_input(today)
  local http = require("http")

  local url = "https://adventofcode.com/2024/day/" .. today.sub(2, 1) .. "/input"

  local session_cookie = "session="

  local res, err = http.get(url, {
    headers = {
      Cookie = session_cookie,
      ["User-Agent"] = "Lua HTTP client"
    }
  })

  if res then
      print("Requisição bem-sucedida!")
      print("Resposta:", res.body)
  else
      print("Erro na requisição:", err)
  end
end

local files, err = get_files()
if err then error(err) end
assert(files)

local today = os.date("%d")

if not files:find(today) then
  create_files(today)
end

local input = get_input(today)
print(input)

