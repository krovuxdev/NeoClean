local M = {}
local reverse = require("utils.core").reverse

---@alias ModeType "normal" | "relative" | "hybrid"
---@class DefaultOpts
---@field mode ModeType
---@field textl string|nil
---@field textr string|nil
---@field iconRelnum string
---@field base16 table<string, string>|nil
---@type DefaultOpts
local default_opts = {
	mode = "normal",
	textl = "",
	textr = " ",
	iconRelnum = "  ",
	base16 = {
		base00 = "",
		base01 = "",
		base02 = "",
		base03 = "",
		base04 = "",
		base05 = "",
		base06 = "",
		base07 = "",
		base08 = "",
		base09 = "",
	},
}

local function ShiftMerge(tables, insert)
	for _, value in pairs(tables) do
		table.insert(insert, value)
	end
	table.sort(insert)
	return insert
end

M.Config = {}
M.Config.colors = {}
M.opts = _G.opts or default_opts

---@param opts DefaultOpts
M.setup = function(opts)
	_G.opts = vim.tbl_deep_extend("force", default_opts, opts or {})
	M.update_statuscolumn()
end

M.Config.colors = reverse(ShiftMerge(M.opts.base16, M.Config.colors))

M.update_statuscolumn = function()
	_G.exclude_buftypes = {
		"ministarter",
		"terminal",
		"nofile",
		"help",
		"quickfix",
		"echasnovski/mini.starter",
		"mini.starter",
		"loclist",
		"prompt",
		"man",
		"neotree",
		"neo-tree",
		"starter",
	}
	vim.api.nvim_create_autocmd({ "FileType" }, {
		callback = function()
			local buftype = vim.bo.buftype
			if vim.tbl_contains(exclude_buftypes, buftype) then
				vim.o.statuscolumn = ""
			else
				vim.o.statuscolumn =
					"%!v:lua.require('config/statuscolumn').StatusColumn()"
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			local buftype = vim.bo.buftype
			if vim.tbl_contains(exclude_buftypes, buftype) then
				vim.o.statuscolumn = ""
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "CursorMovedI", "CursorMoved" }, {
		callback = function()
			M.SetHL()
		end,
	})
end

M.StatusColumn = function()
	local text = ""

	M.SetHL()
	text = table.concat({

		"%s",
		"%=",
		M.folds(),
		"%=",
		M.border(),
		"%=",
		M.number(M),
	})
	return text
end

M.border = function()
	local num = vim.v.relnum + 1
	local group = num < 10 and "Gradient_" .. num or "Gradient_10"
	return "%#" .. group .. "#" .. M.opts.textl
end

M.SetHL = function()
	for i, color in ipairs(M.Config.colors) do
		vim.api.nvim_set_hl(0, "Gradient_" .. i, { fg = color })
	end
end

M.number = function(cfg)
	local text = ""
	local lnum_str = tostring(vim.v.lnum)
	local relnum_str = tostring(vim.v.relnum)

	local function format_number(num_str)
		return #num_str == 1 and "" .. num_str .. " " or num_str
	end

	local foldclosed = vim.fn.foldclosed(vim.v.lnum)

	if cfg.opts.mode == "normal" then
		text = format_number(lnum_str) .. M.opts.textr
	elseif cfg.opts.mode == "relative" then
		if vim.v.relnum == 0 then
			text = foldclosed == -1 and format_number(lnum_str)
				or format_number(relnum_str) .. " " .. M.opts.iconRelnum
		else
			text = format_number(relnum_str) .. " " .. M.opts.textr
		end
	elseif cfg.opts.mode == "hybrid" then
		if vim.v.relnum == 0 then
			text = format_number(lnum_str) .. " " .. M.opts.iconRelnum
		else
			text = format_number(relnum_str) .. " " .. M.opts.textr
		end
	end
	-- if cfg.opts.mode == "normal" then
	-- 	text = text .. vim.v.lnum .. M.opts.textr
	-- elseif cfg.opts.mode == "relative" then
	-- 	text = vim.v.relnum == 0 and text .. vim.v.relnum .. M.opts.iconRelnum
	-- 		or vim.v.relnum .. " " .. M.opts.textr
	-- elseif cfg.opts.mode == "hybrid" then
	-- 	text = vim.v.relnum == 0 and text .. vim.v.lnum -- .. M.opts.iconRelnum
	-- 		or text .. vim.v.relnum .. " " .. M.opts.textr
	-- end
	return text
end

M.folds = function()
	local foldlevel = vim.fn.foldlevel(vim.v.lnum)
	local foldlevel_before =
		vim.fn.foldlevel((vim.v.lnum - 1) >= 1 and vim.v.lnum - 1 or 1)
	local foldlevel_after = vim.fn.foldlevel(
		(vim.v.lnum + 1) <= vim.fn.line("$") and (vim.v.lnum + 1)
			or vim.fn.line("$")
	)
	local foldclosed = vim.fn.foldclosed(vim.v.lnum)

	if foldlevel == 0 then
		return ""
	end

	if foldclosed ~= -1 and foldclosed == vim.v.lnum then
		return ""
	end

	if foldlevel > foldlevel_before then
		return "▽ "
	end

	if foldlevel > foldlevel_after then
		return "╰ "
	end

	return "╎ "
end

vim.keymap.set("n", "zd", function()
	vim.cmd("normal! zd")
	vim.cmd("set numberwidth=1")
end)

vim.keymap.set("n", "zD", function()
	vim.cmd("normal! zD")
	vim.cmd("set numberwidth=1")
end)

return M
