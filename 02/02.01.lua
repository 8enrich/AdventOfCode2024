
local read_data = require("read_data")
local level_02 = require("02")

local function analisys_level(level)
  for i=1, #level - 1 do
    if level_02.get_level_differ(level, i) then return false end
  end
  return true
end

local function count_safe_reports(reports)
  local count = 0
  for i=1, #reports do
    if analisys_level(reports[i]) then
      count = count + 1
    end
  end
  return count
end

local reports = read_data.get_reports()

local safe_reports = count_safe_reports(reports)
print(safe_reports)
