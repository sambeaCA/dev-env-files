local M = {}

local group_modules = {
  "sambea.groups.base",
  "sambea.groups.syntax",
  "sambea.groups.treesitter",
  "sambea.groups.semantic_tokens",
  "sambea.groups.lsp",
  "sambea.groups.telescope",
  "sambea.groups.nvim_tree",
  "sambea.groups.bufferline",
  "sambea.groups.gitsigns",
  "sambea.groups.cmp",
  "sambea.groups.flash",
  "sambea.groups.which_key",
  "sambea.groups.alpha",
  "sambea.groups.trouble",
  "sambea.groups.indent_blankline",
  "sambea.groups.todo_comments",
  "sambea.groups.barbecue",
  "sambea.groups.diff",
}

function M.setup()
  local c = require("sambea.palette")
  local highlights = {}

  for _, mod_name in ipairs(group_modules) do
    local ok, mod = pcall(require, mod_name)
    if ok and mod.get then
      for group, hl in pairs(mod.get(c)) do
        highlights[group] = hl
      end
    end
  end

  for group, hl in pairs(highlights) do
    if type(hl) == "string" then
      hl = { link = hl }
    end
    vim.api.nvim_set_hl(0, group, hl)
  end

  M.terminal(c)
end

function M.terminal(c)
  local t = c.terminal
  vim.g.terminal_color_0 = t.black
  vim.g.terminal_color_1 = t.red
  vim.g.terminal_color_2 = t.green
  vim.g.terminal_color_3 = t.yellow
  vim.g.terminal_color_4 = t.blue
  vim.g.terminal_color_5 = t.magenta
  vim.g.terminal_color_6 = t.cyan
  vim.g.terminal_color_7 = t.white
  vim.g.terminal_color_8 = t.bright_black
  vim.g.terminal_color_9 = t.bright_red
  vim.g.terminal_color_10 = t.bright_green
  vim.g.terminal_color_11 = t.bright_yellow
  vim.g.terminal_color_12 = t.bright_blue
  vim.g.terminal_color_13 = t.bright_magenta
  vim.g.terminal_color_14 = t.bright_cyan
  vim.g.terminal_color_15 = t.bright_white
end

return M
