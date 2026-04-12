local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    WhichKey = { fg = c.green },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.fg },
    WhichKeySeparator = { fg = c.dark5 },
    WhichKeyNormal = { bg = c.bg_popup },
    WhichKeyBorder = { fg = c.border_highlight, bg = c.bg_popup },
    WhichKeyValue = { fg = c.dark5 },
  }
end

return M
