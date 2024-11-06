return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  -- event = "VeryLazy",
  cmd = "Neotree",
  keys = {
    { "<leader>e", ":Neotree toggle<CR>", silent = true, desc = "File Explorer", remap = true },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "single",
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,

        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules",
          },
        },
      },
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = "   Files " },
          { source = "buffers", display_name = "   Bufs " },
          { source = "git_status", display_name = "   Git " },
        },
      },
      window = {
        reveal = true,
        position = "right",
        -- position = "float",
        width = 35,
        -- popup = {
        --   size = {
        --     height = "40%",
        --     width = 65,
        --   },
        -- },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            -- unstaged = "",
            ignored = "",
            staged = "󰱒",
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            conflict = "",
          },
        },
      },
    })
  end,
}
