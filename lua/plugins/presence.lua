return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    build = "./build",
    config = function()
      require("cord").setup({
        usercmds = true,
        log_level = nil,      -- One of 'trace', 'debug', 'info', 'warn', 'error', 'off'
        timer = {
          interval = 1500,    -- Interval between presence updates in milliseconds (min 500)
          reset_on_idle = false, -- Reset start timestamp on idle
          reset_on_change = false, -- Reset start timestamp on presence change
        },
        editor = {
          image = "https://i.pinimg.com/originals/e0/19/dd/e019dd90566b6e72abc8166614eee7e5.gif",
          client = "neovim", -- vim, neovim, lunarvim, nvchad, astronvim or your application's client id
          tooltip = "Viva Rust", -- Text to display when hovering over the editor's image
        },
        display = {
          show_time = true,
          show_repository = true,
          show_cursor_position = true,
          swap_fields = false,
          swap_icons = true,
          workspace_blacklist = {},
        },
        lsp = {
          show_problem_count = false, -- Display number of diagnostics problems
          severity = 1,          -- 1 = Error, 2 = Warning, 3 = Info, 4 = Hint
          scope = "workspace",   -- buffer or workspace
        },
        idle = {
          enable = true,
          show_status = true,
          timeout = 0,
          disable_on_focus = true,
          text = "Descanso",
          tooltip = "💤",
        },
        text = {
          viewing = "Viewing {}",
          editing = "Editing {}",
          file_browser = "Browsing files in {}",
          plugin_manager = "Managing plugins in {}",
          lsp_manager = "Configuring LSP in {}",
          vcs = "Committing changes in {}",
          workspace = "",
        },
        buttons = {
          {
            label = "Push Me",
            url = "https://github.com/krovuxdev",
          },
        },
      })
    end,
  },
}
