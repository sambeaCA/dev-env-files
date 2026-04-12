local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    LspReferenceText = { bg = c.bg_highlight },
    LspReferenceRead = { bg = c.bg_highlight },
    LspReferenceWrite = { bg = c.bg_highlight },
    LspSignatureActiveParameter = { bg = c.bg_visual, bold = true },
    LspCodeLens = { fg = c.dark3 },
    LspInlayHint = { fg = c.dark5, bg = c.bg_highlight, italic = true },
    LspInfoBorder = { fg = c.border_highlight },
    healthError = { fg = c.error },
    healthSuccess = { fg = c.green },
    healthWarning = { fg = c.warning },
  }
end

return M
