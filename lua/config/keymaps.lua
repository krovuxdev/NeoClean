local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "<S-Tab>", "<C-d>", opts)
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-S-s>", ":wa<CR>", opts)
map("n", "<M-.>", ":CommentToggle<CR>", opts)
map("v", "<M-.>", ":CommentToggle<CR>", opts)

map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

map("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

map("n", "<C-a>", "gg<S-v>G")
map("v", "<C-a>", "<Esc>")

map("n", "ss", ":split<Return>", opts)
map("n", "sv", ":vsplit<Return>", opts)

map("n", "<esc>", ":noh<CR>", opts)
map("n", "<C-x>", ":bd<CR>", opts)

map("n", "<M-h>", ":bprevious<CR>", opts)
map("n", "<M-l>", ":bnext<CR>", opts)
map("n", "<c-t>", ":tabnew<CR>", opts)
map("n", "tt", ":tabnew<CR>", opts)
map("n", "tr", ":tabclose<CR>", opts)
map("n", "tj", ":tabprevious<CR>", opts)
map("n", "tk", ":tabnext<CR>", opts)
