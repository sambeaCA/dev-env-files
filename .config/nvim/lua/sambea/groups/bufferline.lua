local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    BufferLineIndicatorSelected = { fg = c.green },
    BufferLineFill = { bg = c.bg_dark },
    BufferLineBackground = { fg = c.dark5, bg = c.bg_dark },
    BufferLineBufferSelected = { fg = c.fg, bg = c.bg, bold = true },
    BufferLineBufferVisible = { fg = c.dark5, bg = c.bg },
    BufferLineSeparator = { fg = c.bg_dark, bg = c.bg_dark },
    BufferLineSeparatorSelected = { fg = c.bg_dark },
    BufferLineSeparatorVisible = { fg = c.bg_dark },
    BufferLineModified = { fg = c.git_change },
    BufferLineModifiedSelected = { fg = c.git_change },
    BufferLineModifiedVisible = { fg = c.git_change },
  }
end

return M
