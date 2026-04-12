local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    Comment = { fg = c.comment, italic = true },
    Constant = { fg = c.orange },
    String = { fg = c.green },
    Character = { fg = c.green },
    Number = { fg = c.orange },
    Boolean = { fg = c.orange },
    Float = { fg = c.orange },
    Identifier = { fg = c.fg },
    Function = { fg = c.blue },
    Statement = { fg = c.purple },
    Conditional = { fg = c.cyan },
    Repeat = { fg = c.cyan },
    Label = { fg = c.cyan },
    Operator = { fg = c.blue5 },
    Keyword = { fg = c.purple, italic = true },
    Exception = { fg = c.purple },
    PreProc = { fg = c.cyan },
    Include = { fg = c.cyan },
    Define = { fg = c.purple },
    Macro = { fg = c.purple },
    PreCondit = { fg = c.cyan },
    Type = { fg = c.blue1 },
    StorageClass = { fg = c.cyan },
    Structure = { fg = c.blue1 },
    Typedef = { fg = c.blue1 },
    Special = { fg = c.magenta },
    SpecialChar = { fg = c.magenta },
    Tag = { fg = c.red },
    Delimiter = { fg = c.brand_dust },
    SpecialComment = { fg = c.teal, italic = true },
    Debug = { fg = c.orange },
    Error = { fg = c.error },
  }
end

return M
