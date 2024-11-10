local diagnostic_icons = require("config").icons.diagnostics
------------------------------------------------------------------------------
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.autowrite = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.confirm = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
------------------------------------------------------------------------------
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
------------------------------------------------------------------------------
vim.o.complete = "."
vim.o.completeopt = "menu,menuone,noselect"
------------------------------------------------------------------------------
vim.opt.signcolumn = "yes"
vim.g.autoformat = true
vim.opt.wrap = false
------------------------------------------------------------------------------
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
			[vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
			[vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
		},
	},
	update_in_insert = true,
	virtual_text = false,
	virtual_lines = true,

	float = {
		focusable = false,
		max_width = 80,
		wrap = true,
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		scope = "cursor",
		-- prefix = "●",
	},
})
------------------------------------------------------------------------------
require("config.statuscolumn").setup({
	mode = "hybrid",
	iconRelnum = "",
	base16 = {
		base00 = "#fbf1c7",
		base01 = "#e9d5a4",
		base02 = "#d7b980",
		base03 = "#c5a25d",
		base04 = "#b4923a",
		base05 = "#a48024",
		base06 = "#8c6b1b",
		base07 = "#73510f",
		base08 = "#5a3a08",
		base09 = "#593a0a",

		-- "#3b3b3b",
	},
	-- textr = "│",
})
------------------------------------------------------------------------------
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })
vim.cmd("highlight Winbar guibg=none")
