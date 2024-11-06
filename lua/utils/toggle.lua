local M = {}
_G.Enabled = true
function M.ToggleEnabled()
  _G.Enabled = not _G.Enabled
  return _G.Enabled
end

return M
