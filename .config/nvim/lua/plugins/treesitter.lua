return {
  "romus204/tree-sitter-manager.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("tree-sitter-manager").setup({
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      },
      highlight = true,
      auto_install = true,
    })
  end,
}
