local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    -- ── Misc ────────────────────────────────────────────────
    ["@none"] = { fg = "NONE" },
    ["@comment"] = { fg = c.comment, italic = true },
    ["@comment.documentation"] = { fg = c.comment, italic = true },
    ["@comment.error"] = { fg = c.error },
    ["@comment.warning"] = { fg = c.warning },
    ["@comment.todo"] = { fg = c.bg, bg = c.blue, bold = true },
    ["@comment.note"] = { fg = c.hint },
    ["@annotation"] = { fg = c.yellow },
    ["@attribute"] = { fg = c.yellow },

    -- ── Punctuation ─────────────────────────────────────────
    ["@punctuation.bracket"] = { fg = c.brand_dust },
    ["@punctuation.delimiter"] = { fg = c.brand_dust },
    ["@punctuation.special"] = { fg = c.blue5 },

    -- ── Literals ────────────────────────────────────────────
    ["@string"] = { fg = c.green },
    ["@string.documentation"] = { fg = c.green },
    ["@string.escape"] = { fg = c.magenta },
    ["@string.regexp"] = { fg = c.orange },
    ["@string.special"] = { fg = c.magenta },
    ["@string.special.symbol"] = { fg = c.green1 },
    ["@string.special.url"] = { fg = c.teal, underline = true },
    ["@character"] = { fg = c.green },
    ["@character.special"] = { fg = c.magenta },
    ["@boolean"] = { fg = c.orange, bold = true },
    ["@number"] = { fg = c.orange },
    ["@number.float"] = { fg = c.orange },

    -- ── Functions ───────────────────────────────────────────
    ["@function"] = { fg = c.blue },
    ["@function.builtin"] = { fg = c.blue },
    ["@function.call"] = { fg = c.blue },
    ["@function.macro"] = { fg = c.purple },
    ["@function.method"] = { fg = c.blue },
    ["@function.method.call"] = { fg = c.blue },

    -- ── Keywords ────────────────────────────────────────────
    ["@keyword"] = { fg = c.purple, italic = true },
    ["@keyword.conditional"] = { fg = c.cyan },
    ["@keyword.coroutine"] = { fg = c.purple, italic = true },
    ["@keyword.debug"] = { fg = c.orange },
    ["@keyword.directive"] = { fg = c.cyan },
    ["@keyword.exception"] = { fg = c.purple },
    ["@keyword.function"] = { fg = c.purple, italic = true },
    ["@keyword.import"] = { fg = c.cyan },
    ["@keyword.modifier"] = { fg = c.purple, italic = true },
    ["@keyword.operator"] = { fg = c.cyan },
    ["@keyword.repeat"] = { fg = c.cyan },
    ["@keyword.return"] = { fg = c.purple, italic = true },
    ["@keyword.type"] = { fg = c.blue1 },

    -- ── Operators ───────────────────────────────────────────
    ["@operator"] = { fg = c.blue5 },

    -- ── Types ───────────────────────────────────────────────
    ["@type"] = { fg = c.blue1 },
    ["@type.builtin"] = { fg = c.blue1, italic = true },
    ["@type.definition"] = { fg = c.blue1 },
    ["@type.qualifier"] = { fg = c.purple },

    -- ── Variables ───────────────────────────────────────────
    ["@variable"] = { fg = c.fg },
    ["@variable.builtin"] = { fg = c.red, italic = true },
    ["@variable.member"] = { fg = c.green1 },
    ["@variable.parameter"] = { fg = c.yellow },
    ["@variable.parameter.builtin"] = { fg = c.yellow, italic = true },

    -- ── Identifiers ─────────────────────────────────────────
    ["@constant"] = { fg = c.orange },
    ["@constant.builtin"] = { fg = c.orange, bold = true },
    ["@constant.macro"] = { fg = c.orange },
    ["@module"] = { fg = c.blue },
    ["@module.builtin"] = { fg = c.blue, italic = true },
    ["@label"] = { fg = c.cyan },

    -- ── Constructors ────────────────────────────────────────
    ["@constructor"] = { fg = c.magenta },

    -- ── Properties ──────────────────────────────────────────
    ["@property"] = { fg = c.green1 },

    -- ── Tags (HTML/JSX) ─────────────────────────────────────
    ["@tag"] = { fg = c.red },
    ["@tag.attribute"] = { fg = c.yellow },
    ["@tag.builtin"] = { fg = c.red },
    ["@tag.delimiter"] = { fg = c.brand_dust },

    -- ── Markup ──────────────────────────────────────────────
    ["@markup"] = { fg = c.fg },
    ["@markup.emphasis"] = { italic = true },
    ["@markup.environment"] = { fg = c.purple },
    ["@markup.heading"] = { fg = c.blue, bold = true },
    ["@markup.heading.1"] = { fg = c.blue, bold = true },
    ["@markup.heading.2"] = { fg = c.yellow, bold = true },
    ["@markup.heading.3"] = { fg = c.green, bold = true },
    ["@markup.heading.4"] = { fg = c.teal, bold = true },
    ["@markup.heading.5"] = { fg = c.magenta, bold = true },
    ["@markup.heading.6"] = { fg = c.purple, bold = true },
    ["@markup.link"] = { fg = c.teal, underline = true },
    ["@markup.link.label"] = { fg = c.blue },
    ["@markup.link.url"] = { fg = c.teal, underline = true },
    ["@markup.list"] = { fg = c.cyan },
    ["@markup.list.checked"] = { fg = c.green },
    ["@markup.list.unchecked"] = { fg = c.dark5 },
    ["@markup.math"] = { fg = c.blue },
    ["@markup.raw"] = { fg = c.green },
    ["@markup.raw.block"] = { fg = c.fg },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.quote"] = { fg = c.comment, italic = true },

    -- ── Diff ────────────────────────────────────────────────
    ["@diff.plus"] = { fg = c.git_add },
    ["@diff.minus"] = { fg = c.git_delete },
    ["@diff.delta"] = { fg = c.git_change },
  }
end

return M
