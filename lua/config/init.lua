local M = {}
M.logos = {
	[[
          ▒▒▒▒▒▒▒▒
       ▒▒▒▒▒▒                ▒▒▒▒▒▒
       ▒▒▒▒▒▒▒▒▒▒        ▒▒▒▒▒▒▒▒▒▒
     ▒▒▒▒▒▒▒▒▒▒            ▒▒▒▒▒▒▒▒▒▒
     ▒▒▒▒      ██        ██      ▒▒▒▒
     ▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒
     ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
       ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
           ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
       ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
     ▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒
           ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
         ▒▒▒▒    ▒▒▒▒▒▒▒▒    ▒▒▒▒
╔═══════════════════════════════════════╗
║             ┳┓    ┏┓┓                 ║
║             ┃┃┏┓┏┓┃ ┃┏┓┏┓┏┓           ║
║             ┛┗┗ ┗┛┗┛┗┗ ┗┻┛┗           ║
╚═══════════════════════════════════════╝
  ]],
}
M.colors = {
	green = "String",
	blue = "Function",
	peach = "Identifier",
	purple = "Keyword",
	cyan = "Operator",
	pink = "Special",
	yellow = "Yellow",
}
M.icons = {
	packages = {
		package_installed = "✓",
		package_pending = "➜",
		package_uninstalled = "✗",
	},
	misc = {
		dots = "󰇘",
	},
	dap = {
		Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
		Breakpoint = " ",
		BreakpointCondition = " ",
		BreakpointRejected = { " ", "DiagnosticError" },
		LogPoint = ".>",
	},
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	git = {
		added = " ",
		modified = " ",
		removed = " ",
	},
	kind_icons = {
		Array = "",
		Boolean = "󰨙",
		Class = "",
		Codeium = "󰘦",
		Collapsed = "",
		Color = "",
		Constant = "",
		-- Constructor = " ",
		Constructor = "",
		Control = "",
		Copilot = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		Module = "",
		Namespace = "󰦮",
		Null = "",
		Number = "󰎠",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		-- Reference = " ",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "󰆼",
		-- Struct = "  ",
		TabNine = "󰏚",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
	},
}
M.kind_score = {
	Text = 1,
	Method = 2,
	Function = 3,
	Constructor = 4,
	Field = 5,
	Variable = 6,
	Class = 7,
	Interface = 8,
	Module = 9,
	Property = 10,
	Unit = 11,
	Value = 12,
	Enum = 13,
	Keyword = 14,
	Snippet = 15,
}
return M
