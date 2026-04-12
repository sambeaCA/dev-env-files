local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    -- ── Base Types ──────────────────────────────────────────
    ["@lsp.type.boolean"] = { link = "@boolean" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.class"] = { fg = c.blue1 },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { fg = c.yellow },
    ["@lsp.type.deriveHelper"] = { fg = c.yellow },
    ["@lsp.type.enum"] = { fg = c.blue1 },
    ["@lsp.type.enumMember"] = { fg = c.orange },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.event"] = { fg = c.orange },
    ["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.generic"] = { fg = c.fg },
    ["@lsp.type.interface"] = { fg = c.blue1 },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.lifetime"] = { fg = c.purple, italic = true },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.method"] = { link = "@function.method" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.regexp"] = { link = "@string.regexp" },
    ["@lsp.type.selfKeyword"] = { fg = c.red, italic = true },
    ["@lsp.type.selfTypeKeyword"] = { fg = c.blue1 },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.struct"] = { fg = c.blue1 },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.typeParameter"] = { fg = c.yellow },
    ["@lsp.type.unresolvedReference"] = { sp = c.error, undercurl = true },
    ["@lsp.type.variable"] = {},

    -- ── Type Modifiers ──────────────────────────────────────
    ["@lsp.typemod.class.defaultLibrary"] = { fg = c.blue1, italic = true },
    ["@lsp.typemod.enum.defaultLibrary"] = { fg = c.blue1, italic = true },
    ["@lsp.typemod.enumMember.defaultLibrary"] = { fg = c.orange, bold = true },
    ["@lsp.typemod.function.defaultLibrary"] = { fg = c.blue, italic = true },
    ["@lsp.typemod.keyword.async"] = { fg = c.purple, italic = true },
    ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
    ["@lsp.typemod.macro.defaultLibrary"] = { fg = c.purple },
    ["@lsp.typemod.method.defaultLibrary"] = { fg = c.blue, italic = true },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.struct.defaultLibrary"] = { fg = c.blue1, italic = true },
    ["@lsp.typemod.type.defaultLibrary"] = { fg = c.blue1, italic = true },
    ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = c.blue1, italic = true },
    ["@lsp.typemod.variable.callable"] = { link = "@function" },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = c.red, italic = true },
    ["@lsp.typemod.variable.globalScope"] = { fg = c.orange },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },
    ["@lsp.typemod.variable.readonly"] = { fg = c.orange },
    ["@lsp.typemod.variable.static"] = { fg = c.orange },
  }
end

return M
