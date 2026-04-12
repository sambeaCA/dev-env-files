local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    -- todo-comments reads from these highlight groups for keyword coloring
    TodoBgTODO = { fg = c.bg, bg = c.blue, bold = true },
    TodoFgTODO = { fg = c.blue },
    TodoBgFIX = { fg = c.bg, bg = c.error, bold = true },
    TodoFgFIX = { fg = c.error },
    TodoBgHACK = { fg = c.bg, bg = c.warning, bold = true },
    TodoFgHACK = { fg = c.warning },
    TodoBgWARN = { fg = c.bg, bg = c.warning, bold = true },
    TodoFgWARN = { fg = c.warning },
    TodoBgNOTE = { fg = c.bg, bg = c.hint, bold = true },
    TodoFgNOTE = { fg = c.hint },
    TodoBgPERF = { fg = c.bg, bg = c.purple, bold = true },
    TodoFgPERF = { fg = c.purple },
    TodoBgTEST = { fg = c.bg, bg = c.cyan, bold = true },
    TodoFgTEST = { fg = c.cyan },
    TodoSignTODO = { fg = c.blue },
    TodoSignFIX = { fg = c.error },
    TodoSignHACK = { fg = c.warning },
    TodoSignWARN = { fg = c.warning },
    TodoSignNOTE = { fg = c.hint },
    TodoSignPERF = { fg = c.purple },
    TodoSignTEST = { fg = c.cyan },
  }
end

return M
