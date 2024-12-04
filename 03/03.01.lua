
local read_data = require("read_data")
local level_03 = require("03")

local memory = read_data.get_memory()
local muls = level_03.get_muls(memory)
local result = level_03.calculate_muls(muls)

print(result)
