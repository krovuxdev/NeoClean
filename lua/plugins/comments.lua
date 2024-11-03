return {
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({
        comment_empty = false,
        comment_empty_trim_whitespace = true,
      })
    end,
  },
}
