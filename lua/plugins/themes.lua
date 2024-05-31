return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  { "DeviusVim/deviuspro.nvim" },
}
