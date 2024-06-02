return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    dependencies = {
      "DeviusVim/deviuspro.nvim",
    },
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
