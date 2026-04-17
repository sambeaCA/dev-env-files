local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    BlinkCmpMenu = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpMenuBorder = { fg = c.border_highlight, bg = c.bg_popup },
    BlinkCmpMenuSelection = { bg = c.bg_highlight, bold = true },
    BlinkCmpScrollBarThumb = { bg = c.fg_dark },
    BlinkCmpScrollBarGutter = { bg = c.bg_popup },

    BlinkCmpLabel = { fg = c.fg },
    BlinkCmpLabelDeprecated = { fg = c.dark5, strikethrough = true },
    BlinkCmpLabelMatch = { fg = c.blue1, bold = true },
    BlinkCmpLabelDetail = { fg = c.dark5 },
    BlinkCmpLabelDescription = { fg = c.dark5 },

    BlinkCmpSource = { fg = c.dark5 },
    BlinkCmpGhostText = { fg = c.dark3, italic = true },

    BlinkCmpDoc = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpDocBorder = { fg = c.border_highlight, bg = c.bg_popup },
    BlinkCmpDocSeparator = { fg = c.border_highlight, bg = c.bg_popup },

    BlinkCmpSignatureHelp = { fg = c.fg, bg = c.bg_popup },
    BlinkCmpSignatureHelpBorder = { fg = c.border_highlight, bg = c.bg_popup },
    BlinkCmpSignatureHelpActiveParameter = { fg = c.orange, bold = true },

    BlinkCmpKind = { fg = c.fg_dark },
    BlinkCmpKindClass = { fg = c.blue1 },
    BlinkCmpKindColor = { fg = c.magenta },
    BlinkCmpKindConstant = { fg = c.orange },
    BlinkCmpKindConstructor = { fg = c.magenta },
    BlinkCmpKindEnum = { fg = c.blue1 },
    BlinkCmpKindEnumMember = { fg = c.orange },
    BlinkCmpKindEvent = { fg = c.orange },
    BlinkCmpKindField = { fg = c.green1 },
    BlinkCmpKindFile = { fg = c.blue },
    BlinkCmpKindFolder = { fg = c.blue },
    BlinkCmpKindFunction = { fg = c.blue },
    BlinkCmpKindInterface = { fg = c.blue1 },
    BlinkCmpKindKeyword = { fg = c.purple },
    BlinkCmpKindMethod = { fg = c.blue },
    BlinkCmpKindModule = { fg = c.blue },
    BlinkCmpKindOperator = { fg = c.blue5 },
    BlinkCmpKindProperty = { fg = c.green1 },
    BlinkCmpKindReference = { fg = c.orange },
    BlinkCmpKindSnippet = { fg = c.teal },
    BlinkCmpKindStruct = { fg = c.blue1 },
    BlinkCmpKindText = { fg = c.fg },
    BlinkCmpKindTypeParameter = { fg = c.yellow },
    BlinkCmpKindUnit = { fg = c.orange },
    BlinkCmpKindValue = { fg = c.orange },
    BlinkCmpKindVariable = { fg = c.fg },
  }
end

return M
