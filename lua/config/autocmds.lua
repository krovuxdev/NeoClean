vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    vim.keymap.set("n", "<leader><space>", "<cmd>Find<cr>")
    vim.keymap.set("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
    vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
  end,
})
vim.cmd([[
  augroup OpenNeoTreeOnStartup
    autocmd!
    autocmd VimEnter * if isdirectory(expand("%:p")) | execute 'Neotree show right' | endif
  augroup END
]])
