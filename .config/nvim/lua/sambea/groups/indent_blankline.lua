local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    IndentBlanklineChar = { fg = c.fg_gutter, nocombine = true },
    IndentBlanklineContextChar = { fg = c.border_highlight, nocombine = true },
    IblIndent = { fg = c.fg_gutter, nocombine = true },
    IblScope = { fg = c.border_highlight, nocombine = true },
  }
end

return M
