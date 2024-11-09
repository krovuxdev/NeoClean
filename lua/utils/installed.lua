local M = {}
function M.is_Mason_registry(pack)
	local mason_registry = require("mason-registry")
	for _, p in ipairs(pack) do
		local status, package = pcall(mason_registry.get_package, p)
		if status and package then
			if not package:is_installed() then
				vim.cmd("MasonInstall --force " .. p)
			end
		end
	end
end

return M
