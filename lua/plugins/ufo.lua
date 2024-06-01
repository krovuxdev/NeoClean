return {
  "kevinhwang91/nvim-ufo",
  event = "BufEnter",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    require("ufo").setup({
      provider_selector = function(_bufnr, _filetype, _buftype)
        return { "treesitter", "indent" }
      end,
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
          openAllFolds = "zN",
          closeAllFolds = "zn",
          openFoldsExceptKinds = "zr",
          closeFoldsWith = "zR",
        },
      },
    })
  end,
}
