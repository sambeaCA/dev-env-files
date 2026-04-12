return {
  name = "sambea-colorscheme",
  dir = vim.fn.stdpath("config"),
  priority = 1000,
  config = function()
    vim.cmd("colorscheme sambea")
  end,
}
