local api = vim.api

---@class Preset
---@field left string Left symbol
---@field right string Right symbol
---@field adjust integer Adjustment for left/right mark position

---@type table<string, Preset>
local pairs = {
  rounded = { left = "", right = "", adjust = 0 },
  custom = { left = "󰫣", right = "", adjust = 0 },
  none = { left = "", right = "", adjust = 0 },
}

local SelectUI = {
  ns = 0,
  buf = 0,
  win = 0,
  preset = "rounded",
  hl_mark = "FancyMarks",
  last_selected = 0,
}

function SelectUI:update_hl()
  local visual = api.nvim_get_hl(0, { name = "Visual", link = true })
  local hl_mark = {
    fg = visual.reverse and (visual.guifg or visual.fg) or (visual.guibg or visual.bg),
    bg = "none",
  }
  api.nvim_set_hl(0, self.hl_mark, hl_mark)
end

function SelectUI:select()
  local line = api.nvim_get_current_line()
  local unpack = unpack or table.unpack
  if #vim.trim(line) == 0 then
    return
  end
  local row = (select(1, unpack(api.nvim_win_get_cursor(self.win))) - 1)
  api.nvim_buf_clear_namespace(self.buf, self.ns, self.last_selected, self.last_selected + 1)
  local preset = pairs[self.preset]
  local left = math.max(0, (line:find("[^ ]") or 1) - 1 - vim.fn.strdisplaywidth(preset.left) - preset.adjust)
  local right = math.max(0, (line:match(".*()[^ ]") or 1) + preset.adjust)
  for id, pos in ipairs({ left, right }) do
    pcall(api.nvim_buf_set_extmark, self.buf, self.ns, row, pos, {
      id = id,
      virt_text = { { id == 1 and preset.left or preset.right, self.hl_mark } },
      virt_text_pos = "overlay",
    })
  end
  api.nvim_buf_add_highlight(self.buf, self.ns, "Visual", row, left, right)
  self.last_selected = row
end

---@param buf number
function SelectUI:init(buf)
  vim.cmd("hi! Cursor blend=100")
  local augroup = api.nvim_create_augroup("SelectUI_autocmd_" .. buf, { clear = true })
  self.hl_mark = self.hl_mark .. "_" .. buf
  self.win = vim.fn.bufwinid(buf) or vim.api.nvim_get_current_win()
  self.ns = api.nvim_create_namespace("SelectUI_select_" .. buf)
  self.buf = buf
  self:update_hl()
  api.nvim_win_set_hl_ns(self.win, self.ns)
  api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    command = "hi! Cursor blend=100",
    buffer = self.buf,
  })
  api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
    group = augroup,
    command = "hi! Cursor blend=0",
    buffer = self.buf,
  })
  api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    callback = function()
      SelectUI:update_hl()
      vim.cmd("hi! Cursor blend=100")
    end,
    buffer = self.buf,
  })
  api.nvim_create_autocmd("CursorMoved", {
    group = augroup,
    callback = function()
      SelectUI:select()
    end,
    buffer = self.buf,
  })
end

---@alias preset_names 'angle' | 'arrow' | 'custom' | 'inset' | 'none' | 'rounded' | 'uneven'
---@param buf number
---@param preset preset_names optional
function SelectUI.setup(buf, preset)
  SelectUI.preset = vim.tbl_contains(vim.tbl_keys(pairs), preset) and preset or "rounded"
  SelectUI:init(buf)
end

return SelectUI
