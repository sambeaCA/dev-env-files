local inlay_hints = {
  includeInlayParameterNameHints = "literals",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

return {
  settings = {
    typescript = {
      suggest = { completeFunctionCalls = true },
      preferences = {
        includeCompletionsForModuleExports = true,
        importModuleSpecifierPreference = "non-relative",
      },
      inlayHints = inlay_hints,
      format = { enable = false },
    },
    javascript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        importModuleSpecifierPreference = "non-relative",
      },
      inlayHints = inlay_hints,
      format = { enable = false },
    },
  },
}
