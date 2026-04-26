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
      "lua_ls",
      "emmet_ls",
      "pyright",
      "biome",
      "terraformls",
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
      handlers = {
        -- The first entry (default handler)
        --
        function(server_name)
          -- 1. Try to load a custom config from .config/nvim/lua/lsp/server_name.lua
          local status, custom_config = pcall(require, "lsp." .. server_name)

          if status then
            -- If the file exists, use the settings from that file
            require("lspconfig")[server_name].setup(custom_config)
          else
            -- If no custom file exists, just do a default setup
            require("lspconfig")[server_name].setup({})
          end
        end,

        -- You can still add specific overrides here if needed:
        -- ["lua_ls"] = function() ... end,
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "biome",  -- biome linter/formatter
        "stylua", -- lua formatter
        "isort",  -- python import sorter
        "black",  -- python formatter
        "pylint", -- python linter
        "tflint", -- Terraform linter
      },
    })
  end,
}
