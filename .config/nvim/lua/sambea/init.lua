local M = {}

function M.load()
  -- Clear module cache for hot-reloading
  for key, _ in pairs(package.loaded) do
    if key:match("^sambea") then
      package.loaded[key] = nil
    end
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "sambea"

  require("sambea.theme").setup()
end

return M
