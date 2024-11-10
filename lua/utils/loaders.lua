local M = {}
function M.setup(config, manager)
	if type(config) == "string" then
		config = { import = config }
	end
	local directory = config.import

	require(directory .. "." .. manager)
	local dir_path = vim.fn.stdpath("config") .. "/lua/" .. directory
	for _, file in ipairs(vim.fn.globpath(dir_path, "*.lua", false, true)) do
		require(
			directory
				.. "."
				.. (file:match("^.+/([^/]+)%.lua$") or ""):gsub("^Lazy$", "")
		)
	end
end

return M
