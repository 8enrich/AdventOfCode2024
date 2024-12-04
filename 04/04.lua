
local function take_some(value, s, sum, word_len)
  local sub_str = ""
  local j = value
  for i=1, word_len do
    sub_str = sub_str .. s:sub(j, j)
    j = j + sum
  end
  return sub_str
end

local function diagonal_1(value, s, len_line, word_len)
  if (value%len_line) + word_len - 1 > len_line then return "" end
  return take_some(value, s, len_line + 1, word_len)
end

local function diagonal_2(value, s, len_line, word_len)
  if (value%len_line) - word_len + 1 < 1 then return "" end
  return take_some(value, s, len_line - 1, word_len)
end

return {
  take_some = take_some,
  diagonal_1 = diagonal_1,
  diagonal_2 = diagonal_2
}
