local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    diffAdded = { fg = c.git_add },
    diffRemoved = { fg = c.git_delete },
    diffChanged = { fg = c.git_change },
    diffOldFile = { fg = c.yellow },
    diffNewFile = { fg = c.orange },
    diffFile = { fg = c.blue },
    diffLine = { fg = c.dark5 },
    diffIndexLine = { fg = c.magenta },
  }
end

return M
