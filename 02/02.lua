
local function get_level_differ(level, i)
  if level[1] >= level[2] then
    return level[i] - level[i + 1] < 1 or level[i] - level[i + 1] > 3
  end
  return level[i] - level[i + 1] < -3 or level[i] - level[i + 1] > -1
end

return {
  get_level_differ = get_level_differ
}
