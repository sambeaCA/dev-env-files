return {
  -- 1. Corrected the GitHub repository names to williamboman
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig", -- 2. Added missing lspconfig dependency
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local lspconfig = require("lspconfig") -- Cached for efficiency

    local servers = {
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "lua_ls",
      "emmet_ls",
      "pyright",
      "biome",
      "terraformls",
      "svelte",
      "jsonls",
      "yamlls",
      "taplo",
      "rust_analyzer",
      "gopls",
      "marksman",
    }

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
      handlers = {
        function(server_name)
          -- Safe require for custom settings in lua/lsp/<server_name>.lua
          local status, custom_config = pcall(require, "lsp." .. server_name)

          -- Make sure custom_config is a table, default to empty table if not
          if not status or type(custom_config) ~= "table" then
            custom_config = {}
          end

          lspconfig[server_name].setup(custom_config)
        end,
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "biome",
        "stylua",
        "isort",
        "black",
        "pylint",
        "tflint",
        "gofumpt",
        "goimports",
      },
    })
  end,
}
