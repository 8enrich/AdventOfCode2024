
local read_data = require("read_data")
local level_02 = require("02")

local function analisys_level(level)
  for i=1, #level - 1 do
    if level_02.get_level_differ(level, i) then return false, i end
  end
  return true, 0
end

local function reanalyze(level, index)
  if index == 0 then return false end
  local new_level = {table.unpack(level)}
  table.remove(new_level, index)
  return analisys_level(new_level)
end

local function count_safe_reports(reports)
  local count = 0
  for i=1, #reports do
    local safe, index = analisys_level(reports[i])
    if safe or reanalyze(reports[i], index) or reanalyze(reports[i], index + 1) or reanalyze(reports[i], index - 1) then
      count = count + 1
    end
  end
  return count
end

local reports, err = read_data.get_reports()

if err then error(err) end

local safe_reports = count_safe_reports(reports)
print(safe_reports)
