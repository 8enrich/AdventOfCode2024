
local read_data = require("read_data")
local level_06 = require("06")

local data = read_data.get()
local locals = level_06.get_locals(data)
print(#locals)
