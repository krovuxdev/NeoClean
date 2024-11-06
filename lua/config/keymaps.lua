local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "<S-Tab>", "<C-d>", opts)
keymap.set("n", "<C-s>", ":w<CR>", opts)
keymap.set("n", "<C-S-s>", ":wa<CR>", opts)
keymap.set("n", "<M-.>", ":CommentToggle<CR>", opts)
keymap.set("v", "<M-.>", ":CommentToggle<CR>", opts)
--
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "-", "<C-x>", opts)
--
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
--
keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("v", "<C-a>", "<Esc>")
--
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
--
keymap.set("n", "<esc>", ":noh<CR>", opts)
keymap.set("n", "<C-x>", ":bd<CR>", opts)
--
keymap.set("n", "<M-h>", ":bprevious<CR>", opts)
keymap.set("n", "<M-l>", ":bnext<CR>", opts)
--
