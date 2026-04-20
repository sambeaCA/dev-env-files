return {
  settings = {
    typescript = {
      suggest = { completeFunctionCalls = true },
      preferences = {
        includeCompletionsForModuleExports = true,
        importModuleSpecifierPreference = "non-relative",
      },
    },
    javascript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        importModuleSpecifierPreference = "non-relative",
      },
    },
  },
}
