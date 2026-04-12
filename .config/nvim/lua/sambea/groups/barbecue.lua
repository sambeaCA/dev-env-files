local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    -- Navic groups (used by barbecue for breadcrumb icons)
    NavicText = { fg = c.fg_dark },
    NavicSeparator = { fg = c.dark5 },
    NavicIconsFile = { fg = c.blue },
    NavicIconsModule = { fg = c.blue },
    NavicIconsNamespace = { fg = c.blue },
    NavicIconsPackage = { fg = c.blue },
    NavicIconsClass = { fg = c.blue1 },
    NavicIconsMethod = { fg = c.blue },
    NavicIconsProperty = { fg = c.green1 },
    NavicIconsField = { fg = c.green1 },
    NavicIconsConstructor = { fg = c.magenta },
    NavicIconsEnum = { fg = c.blue1 },
    NavicIconsInterface = { fg = c.blue1 },
    NavicIconsFunction = { fg = c.blue },
    NavicIconsVariable = { fg = c.fg },
    NavicIconsConstant = { fg = c.orange },
    NavicIconsString = { fg = c.green },
    NavicIconsNumber = { fg = c.orange },
    NavicIconsBoolean = { fg = c.orange },
    NavicIconsArray = { fg = c.blue5 },
    NavicIconsObject = { fg = c.blue1 },
    NavicIconsKey = { fg = c.purple },
    NavicIconsNull = { fg = c.red },
    NavicIconsEnumMember = { fg = c.orange },
    NavicIconsStruct = { fg = c.blue1 },
    NavicIconsEvent = { fg = c.orange },
    NavicIconsOperator = { fg = c.blue5 },
    NavicIconsTypeParameter = { fg = c.yellow },
  }
end

return M
