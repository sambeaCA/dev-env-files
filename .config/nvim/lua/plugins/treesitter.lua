return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    -- The main branch has a minimal setup — Neovim 0.12+ handles
    -- highlighting natively. This plugin provides parser management
    -- (install/update) and query files.
    require("nvim-treesitter").setup()
  end,
}
