return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")
    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    local servers = {
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "svelte",
      "lua_ls",
      "emmet_ls",
      "prismals",
      "pyright",
      "biome",
    }
    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = servers,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "biome", -- biome linter/formatter (used by ALE)
        "stylua", -- lua formatter (used by ALE)
        "isort", -- python import sorter (used by ALE)
        "black", -- python formatter (used by ALE)
        "pylint", -- python linter (used by ALE)
      },
    })
  end,
}
