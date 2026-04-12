local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    AlphaHeader = { fg = c.green },
    AlphaHeaderLabel = { fg = c.green },
    AlphaButtons = { fg = c.blue },
    AlphaShortcut = { fg = c.orange },
    AlphaFooter = { fg = c.comment, italic = true },
  }
end

return M
