return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  cmd = { "Telescope" },
  dependencies = { "plenary" },
  config = function(_, opts)
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
    local function flash(prompt_bufnr)
      require("flash").jump({
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      })
    end
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
    })

    local actions = require("telescope.actions")
    --
    local open_with_trouble = function(...)
      return require("trouble.providers.telescope").open_with_trouble(...)
    end
    local open_selected_with_trouble = function(...)
      return require("trouble.providers.telescope").open_selected_with_trouble(...)
    end
    require("telescope").setup({
      --starts
      defaults = {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "bottom" },
        sorting_strategy = "ascending",
        winblend = 0,
        prompt_prefix = " 󱓇 ",
        selection_caret = "󱖲 ",
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,

        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_selected_with_trouble,
            -- ["<a-i>"] = find_files_no_ignore,
            -- ["<C-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },

      optional = true,
      --endBlcok
    })
  end,
  keys = {
    -- find
    -- TODO: Find Files with plugins, archive, Dir
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>C",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config",
    },
    {
      "<leader>C/",
      function()
        require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config",
    },
    -- DO.not
    {
      "<leader>W/",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
      end,
      desc = "Find Config",
    },
    {
      "<leader><space>",
      function()
        require("telescope.builtin").find_files({ cwd = vim.uv.cwd() })
      end,
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({ cwd = vim.uv.cwd() })
      end,
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({ cwd = false })
      end,
      desc = "Find Files (cwd)",
    },
    {
      "<leader>fc",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>fR",
      function()
        require("telescope.builtin").oldfiles({ cwd = vim.uv.cwd() })
      end,
      desc = "Recent (cwd)",
    },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                 desc = "Recent" },
    -- HACK: Grep
    {
      "<leader>/",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>sg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>sG",
      function()
        require("telescope.builtin").live_grep({ cwd = false })
      end,
      desc = "Grep (cwd)",
    },
    {
      "<leader>sw",
      function()
        require("telescope.builtin").grep_string({ word_match = "-w" })
      end,
      desc = "Word (Root Dir)",
    },
    {
      "<leader>sW",
      function()
        require("telescope.builtin").grep_string({ cwd = false, word_match = "-w" })
      end,
      desc = "Word (cwd)",
    },
    {
      "<leader>sw",
      function()
        require("telescope.builtin").grep_string()
      end,
      mode = "v",
      desc = "Selection (Root Dir)",
    },
    {
      "<leader>sW",
      function()
        require("telescope.builtin").grep_string({ cwd = false })
      end,
      mode = "v",
      desc = "Selection (cwd)",
    },
    { "<leader>:",  "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },

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
    { "<leader>sj", "<cmd>Telescope jumplist<cr>",    desc = "Jumplist" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",     desc = "Key Maps" },
    { "<leader>sl", "<cmd>Telescope loclist<cr>",     desc = "Location List" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",   desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",       desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>",      desc = "Resume" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>",    desc = "Quickfix List" },

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
