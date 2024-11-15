return {
  "elkowar/yuck.vim",
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "python",
        "tsx",
        "toml",
        "typescript",
        "vim",
        "yaml",
        "rust",
        "toml",
        "ron",
        "nix",
        "just",
        "yuck",
      },
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
    },
  },
}
