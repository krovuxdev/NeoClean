local M = {}
function M.setup(config)
  if type(config) == "string" then
    config = { import = config }
  end
  local directory = config.import
  local dir_path = vim.fn.stdpath("config") .. "/lua/" .. directory
  for _, file in ipairs(vim.fn.globpath(dir_path, "*.lua", false, true)) do
    require(directory .. "." .. (file:match("^.+/([^/]+)%.lua$") or ""):gsub("^Lazy$", ""))
  end
  require(directory .. ".Lazy")
end

return M
