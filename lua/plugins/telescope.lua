return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  cmd = { "Telescope" },
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function(args)
        if args.data.filetype ~= "help" then
          vim.wo.number = true
        elseif args.data.bufname:match("*.csv") then
          vim.wo.wrap = false
        end
      end,
    })
    local actions = require("telescope.actions")
    require("telescope").setup({
      --starts
      defaults = {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "bottom" },
        sorting_strategy = "ascending",
        winblend = 0,
        prompt_prefix = " 󱓇 ",
        selection_caret = "󱖲 ",
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<C-Down>"] = actions.preview_scrolling_down,
            ["<C-Up>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      optional = true,
    })
  end,
  keys = {
    -- TODO: Find Files with plugins, archive, Dir
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>ls",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "symbols inline",
    },

    {
      "<leader><space>",
      function()
        require("telescope.builtin").find_files({ cwd = vim.uv.cwd(), no_ignore = true })
      end,
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>cc",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config",
    },
    {
      "<leader>c/",
      function()
        require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config"), additional_args = { "-u" } })
      end,
      desc = "Grep Config",
    },
    -- HACK: Grep
    {
      "<leader>/",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>sW",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
      end,
      desc = "Word lives",
    },
    {
      "<leader>sw",
      function()
        require("telescope.builtin").grep_string({
          word_match = "-w",
          no_ignore = true,
          additional_args = { "-u" },
        })
      end,
      mode = { "v", "n" },
      desc = "Word lives(all)",
    },

    -- git
    {
      "<leader>fg",
      "<cmd>Telescope git_files<cr>",
      desc = "Find Files (git-files)",
    },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>",               desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>",                desc = "Status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>",                 desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>",           desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",       desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>",               desc = "Workspace Diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
    {
      "<leader>sH",
      "<cmd>Telescope highlights<cr>",
      desc = "Search Highlight Groups",
    },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    -- Colorscheme
    {
      "<leader>uC",
      function()
        require("telescope.builtin").colorscheme({ enable_preview = true })
      end,
      desc = "Colorscheme with Preview",
    },
  },
}
