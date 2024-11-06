local M = {}

function M.reverse(t)
  local n = #t
  local reversed = {}
  for i = n, 1, -1 do
    table.insert(reversed, t[i])
  end
  return reversed
end

function M.len(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

return M
