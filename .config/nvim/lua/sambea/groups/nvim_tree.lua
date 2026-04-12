local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_dark },
    NvimTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg_dark },
    NvimTreeWinSeparator = { fg = c.bg_dark, bg = c.bg_dark },
    NvimTreeRootFolder = { fg = c.green, bold = true },
    NvimTreeFolderIcon = { fg = c.blue },
    NvimTreeFolderName = { fg = c.blue },
    NvimTreeOpenedFolderName = { fg = c.blue, bold = true },
    NvimTreeIndentMarker = { fg = c.fg_gutter },
    NvimTreeGitNew = { fg = c.git_add },
    NvimTreeGitDirty = { fg = c.git_change },
    NvimTreeGitDeleted = { fg = c.git_delete },
    NvimTreeGitStaged = { fg = c.git_add },
    NvimTreeImageFile = { fg = c.magenta },
    NvimTreeOpenedFile = { fg = c.green, bold = true },
    NvimTreeSpecialFile = { fg = c.yellow, underline = true },
    NvimTreeSymlink = { fg = c.teal },
    NvimTreeCursorLine = { bg = c.bg_highlight },
  }
end

return M
