return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
        disable = { "missing-fields" },
      },
      workspace = { checkThirdParty = false },
      completion = { callSnippet = "Replace" },
      hint = { enable = true, arrayIndex = "Disable" },
      format = { enable = false },
      telemetry = { enable = false },
    },
  },
}
