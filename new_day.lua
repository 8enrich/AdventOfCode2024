
local function get_files()
  local handle = io.popen('ls')
  if not handle then return nil, error("Não foi possível ler o diretório.") end
  local result = handle:read('*a')
  handle:close()
  return result, nil
end

local function create_file(today_dir, filename)
  print("Criando arquivo " .. today_dir .. filename)
  os.execute("touch " .. today_dir .. filename)
end

local function create_files(today)
  local today_dir = today .. "/"
  print("Criando diretório " .. today_dir)
  os.execute("mkdir " .. today)
  create_file(today_dir, today .. ".lua")
  create_file(today_dir, today .. ".01.lua")
  create_file(today_dir, today .. ".02.lua")
  create_file(today_dir, "read_data.lua")
  create_file(today_dir, "data.txt")
  return today_dir
end

local function get_input(today)
  package.path = package.path .. ";/usr/local/share/lua/5.3/?.lua;/usr/share/lua/5.3/?.lua"
  package.cpath = package.cpath .. ";/usr/local/lib/lua/5.3/?.so;/usr/lib/lua/5.3/?.so"

  local http = require("socket.http")
  local ltn12 = require("ltn12")
  local std = require("std.std")

  local filename = ".env"
  local env = io.open(filename, "r")
  if not env then return nil, error("Não foi possível abrir o arquivo " .. filename) end

  local variables = {}
  for line in env:lines() do
    local key, value = table.unpack(std.string.split(line, "="))
    variables[key] = value
  end
  env:close()

  local cookie = "session=" .. variables["SESSION"] .. ";"

  local response = {}

  local result, status, headers = http.request {
    url = "https://adventofcode.com/2024/day/" .. tostring(tonumber(today)) .. "/input",
    method = "GET",
    headers = {
      ["Cookie"] = cookie,
      ["User-Agent"] = "LuaSocket"
    },
    sink = ltn12.sink.table(response)
  }

  if status ~= 200 then return nil, error("Não foi possível fazer a requisição") end
  return response, nil
end

local function get_input_str(input)
  local str = ""
  for _, v in ipairs(input) do
    str = str .. v
  end
  return str
end

local files, err = get_files()
if err then error(err) end
assert(files)

local today = os.date("%d")

if not files:find(today) then
  local today_dir = create_files(today)
  local input, err1 = get_input(today)
  if err1 then error(err1) end
  assert(input)
  local input_str = get_input_str(input)

  local input_file = io.open(today_dir .. "data.txt", "w")
  if not input_file then error("Não foi possível abrir o arquivo de input") end
  input_file:write(input_str)
  input_file:close()
  print("Arquivos do dia " .. today .. " criados com sucesso!")
  os.exit()
end

print("Arquivos do dia " .. today .. " já existem!")
