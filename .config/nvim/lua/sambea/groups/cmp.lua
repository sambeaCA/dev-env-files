local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    CmpDocumentation = { fg = c.fg, bg = c.bg_popup },
    CmpDocumentationBorder = { fg = c.border_highlight, bg = c.bg_popup },
    CmpGhostText = { fg = c.dark3, italic = true },
    CmpItemAbbr = { fg = c.fg },
    CmpItemAbbrDeprecated = { fg = c.dark5, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.blue1, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.blue1, bold = true },
    CmpItemMenu = { fg = c.dark5 },

    -- LSP Kind colors
    CmpItemKindDefault = { fg = c.fg_dark },
    CmpItemKindClass = { fg = c.blue1 },
    CmpItemKindColor = { fg = c.magenta },
    CmpItemKindConstant = { fg = c.orange },
    CmpItemKindConstructor = { fg = c.magenta },
    CmpItemKindEnum = { fg = c.blue1 },
    CmpItemKindEnumMember = { fg = c.orange },
    CmpItemKindEvent = { fg = c.orange },
    CmpItemKindField = { fg = c.green1 },
    CmpItemKindFile = { fg = c.blue },
    CmpItemKindFolder = { fg = c.blue },
    CmpItemKindFunction = { fg = c.blue },
    CmpItemKindInterface = { fg = c.blue1 },
    CmpItemKindKeyword = { fg = c.purple },
    CmpItemKindMethod = { fg = c.blue },
    CmpItemKindModule = { fg = c.blue },
    CmpItemKindOperator = { fg = c.blue5 },
    CmpItemKindProperty = { fg = c.green1 },
    CmpItemKindReference = { fg = c.orange },
    CmpItemKindSnippet = { fg = c.teal },
    CmpItemKindStruct = { fg = c.blue1 },
    CmpItemKindText = { fg = c.fg },
    CmpItemKindTypeParameter = { fg = c.yellow },
    CmpItemKindUnit = { fg = c.orange },
    CmpItemKindValue = { fg = c.orange },
    CmpItemKindVariable = { fg = c.fg },
  }
end

return M
