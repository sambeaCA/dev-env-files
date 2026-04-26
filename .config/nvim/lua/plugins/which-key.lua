return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    preset = "modern",
    win = { border = "rounded" },
    sort = { "local", "order", "group", "alphanum", "mod" },
    icons = {
      mappings = true,
      separator = "→",
    },
  },
}
