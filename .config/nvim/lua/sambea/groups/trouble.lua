local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    TroubleText = { fg = c.fg },
    TroubleCount = { fg = c.purple, bg = c.bg_highlight },
    TroubleNormal = { fg = c.fg, bg = c.bg_dark },
    TroubleIndent = { fg = c.fg_gutter },
    TroubleLocation = { fg = c.dark5 },
    TroubleCode = { fg = c.dark5 },
    TroubleSignError = { fg = c.error },
    TroubleSignWarning = { fg = c.warning },
    TroubleSignInformation = { fg = c.info },
    TroubleSignHint = { fg = c.hint },
  }
end

return M
