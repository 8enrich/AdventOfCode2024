
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
    local values = std.string.split(line, "=")
    if not values then return nil, error("Erro ao ler o .env") end
    local key, value = values[1], values[2]
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

if #arg > 1 then
  error("Muitos argumentos mandados de uma só vez\nUso: 'lua " .. arg[0] .. [[
 <dia-do-mês>(Opcional)' 
Caso um dia não seja mandando ele vai rodar com a data de hoje de acordo com o sistema]])
end

local files, err = get_files()
if err then error(err) end
assert(files)

local today = os.date("%d")

if #arg == 1 then
  local day = tonumber(arg[1])
  if day < 1 or day > 25 then
    error("Dia inválido")
  end
  local day_str = arg[1]
  if #day_str == 1 then
    day_str = "0" .. day_str
  end
  today = day_str
end

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
  local file = io.open(today_dir .. today .. ".lua", "w")
  if not file then error("Não foi possível abrir o arquivo do código") end
  local initial_code = [[
package.path = package.path .. ";../?.lua"
local std = require("std.std")

local
  part1,
  part2

local function main()

  local data = std.file.read_lines("data.txt")
  local answer1 = part1(data)
  print("Parte 1: ", answer1)
  local answer2 = part2(data)
  print("Parte 2:", answer2)

end

part1 = function(data) return 0 end

part2 = function(data) return 0 end

main()]]
  file:write(initial_code)
  file:close()
  print("Arquivos do dia " .. today .. " criados com sucesso!")
  os.exit()
end

print("Arquivos do dia " .. today .. " já existem!")
