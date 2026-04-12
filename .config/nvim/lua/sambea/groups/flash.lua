local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    FlashBackdrop = { fg = c.dark3 },
    FlashLabel = { fg = c.bg, bg = c.magenta2, bold = true },
    FlashMatch = { fg = c.blue1, bg = c.bg_visual },
    FlashCurrent = { fg = c.orange },
  }
end

return M
