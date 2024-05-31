local M = {}
function M.setup(directory)
  local dir_path = vim.fn.stdpath("config") .. "/lua/" .. directory
  for _, file in ipairs(vim.fn.globpath(dir_path, "*.lua", false, true)) do
    require(directory .. "." .. file:match("^.+/(.+)%.lua$"))
  end
end

return M
