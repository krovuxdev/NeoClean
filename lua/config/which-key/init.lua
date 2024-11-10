local map = vim.keymap.set
local opts = {
	noremap = true,
	silent = true,
	desc = "Buffer Local Keymaps (which-key)",
}

local wk = require("which-key")
map("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, opts)

wk.add({
	mode = { "n", "v" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>s", group = "Search" },
	{ "<leader>g", group = "Go" },
	{ "g", group = "goto" },
})
