local c = require("sambea.palette")

return {
  normal = {
    a = { bg = c.blue, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_dark, fg = c.fg },
    c = { bg = c.bg_dark, fg = c.fg_dark },
  },
  insert = {
    a = { bg = c.green, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_dark, fg = c.fg },
    c = { bg = c.bg_dark, fg = c.fg_dark },
  },
  visual = {
    a = { bg = c.purple, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_dark, fg = c.fg },
    c = { bg = c.bg_dark, fg = c.fg_dark },
  },
  command = {
    a = { bg = c.yellow, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_dark, fg = c.fg },
    c = { bg = c.bg_dark, fg = c.fg_dark },
  },
  replace = {
    a = { bg = c.red, fg = c.bg, gui = "bold" },
    b = { bg = c.bg_dark, fg = c.fg },
    c = { bg = c.bg_dark, fg = c.fg_dark },
  },
  inactive = {
    a = { bg = c.bg_highlight, fg = c.dark5, gui = "bold" },
    b = { bg = c.bg_highlight, fg = c.dark5 },
    c = { bg = c.bg_highlight, fg = c.dark5 },
  },
}
