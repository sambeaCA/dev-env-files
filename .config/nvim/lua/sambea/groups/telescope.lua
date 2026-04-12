local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    TelescopeBorder = { fg = c.border_highlight, bg = c.bg_popup },
    TelescopeNormal = { fg = c.fg, bg = c.bg_popup },
    TelescopePromptBorder = { fg = c.border_highlight, bg = c.bg_popup },
    TelescopePromptNormal = { fg = c.fg, bg = c.bg_popup },
    TelescopePromptPrefix = { fg = c.green },
    TelescopePromptTitle = { fg = c.bg, bg = c.orange, bold = true },
    TelescopePreviewTitle = { fg = c.bg, bg = c.green, bold = true },
    TelescopeResultsTitle = { fg = c.bg, bg = c.blue, bold = true },
    TelescopeResultsComment = { fg = c.dark5 },
    TelescopeSelection = { bg = c.bg_visual },
    TelescopeSelectionCaret = { fg = c.green },
    TelescopeMatching = { fg = c.blue1, bold = true },
  }
end

return M
