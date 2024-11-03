return {
  "sainnhe/gruvbox-material",
  dependencies = {
    "DeviusVim/deviuspro.nvim",
  },
  noice = false,
  config = function()
    vim.cmd.colorscheme("gruvbox-material")
  end,
}
