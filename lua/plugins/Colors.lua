return {
  "echasnovski/mini.hipatterns",
  -- event = "BufReadPre",
  opts = {},
  config = function()
    local hipatterns = require("mini.hipatterns")
    require("mini.hipatterns").setup({
      highlighters = {
        -- Highlight standalone 'FIX', 'HACK', 'TODO', 'NOTE'
        fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        -- Highlight hex color strings (`#ffffff`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
}
