return {
  filetypes = { "markdown", "markdown.mdx" },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern(".marksman.toml", ".git")(fname) or vim.fn.getcwd()
  end,
  single_file_support = true,
}
