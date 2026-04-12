local M = {}

---@param c SambeaPalette
function M.get(c)
  return {
    -- ── Normal Text ─────────────────────────────────────────
    Normal = { fg = c.fg, bg = c.bg },
    NormalNC = { fg = c.fg, bg = c.bg },
    NormalSB = { fg = c.fg_sidebar, bg = c.bg_dark },
    NormalFloat = { fg = c.fg, bg = c.bg_popup },

    -- ── Cursor ──────────────────────────────────────────────
    Cursor = { fg = c.bg, bg = c.fg },
    lCursor = { fg = c.bg, bg = c.fg },
    CursorIM = { fg = c.bg, bg = c.fg },
    CursorColumn = { bg = c.bg_highlight },
    CursorLine = { bg = c.bg_highlight },
    CursorLineNr = { fg = c.orange, bold = true },

    -- ── Line Numbers ────────────────────────────────────────
    LineNr = { fg = c.fg_gutter },
    LineNrAbove = { fg = c.fg_gutter },
    LineNrBelow = { fg = c.fg_gutter },
    SignColumn = { fg = c.fg_gutter, bg = c.bg },
    SignColumnSB = { fg = c.fg_gutter, bg = c.bg_dark },

    -- ── Fold ────────────────────────────────────────────────
    FoldColumn = { fg = c.dark3, bg = c.bg },
    Folded = { fg = c.blue, bg = c.bg_highlight },

    -- ── Splits & Borders ────────────────────────────────────
    VertSplit = { fg = c.border },
    WinSeparator = { fg = c.border, bold = true },
    FloatBorder = { fg = c.border_highlight, bg = c.bg_popup },
    FloatTitle = { fg = c.orange, bg = c.bg_popup, bold = true },

    -- ── Popup Menu ──────────────────────────────────────────
    Pmenu = { fg = c.fg, bg = c.bg_popup },
    PmenuSel = { bg = c.bg_visual },
    PmenuSbar = { bg = c.bg_highlight },
    PmenuThumb = { bg = c.dark5 },
    PmenuMatch = { fg = c.blue1, bold = true },
    PmenuMatchSel = { fg = c.blue1, bg = c.bg_visual, bold = true },

    -- ── Search & Substitute ─────────────────────────────────
    Search = { fg = c.fg, bg = c.bg_search },
    IncSearch = { fg = c.bg, bg = c.orange },
    CurSearch = { fg = c.bg, bg = c.orange },
    Substitute = { fg = c.bg, bg = c.red },

    -- ── Visual ──────────────────────────────────────────────
    Visual = { bg = c.bg_visual },
    VisualNOS = { bg = c.bg_visual },

    -- ── Diff ────────────────────────────────────────────────
    DiffAdd = { bg = c.diff_add },
    DiffChange = { bg = c.diff_change },
    DiffDelete = { bg = c.diff_delete },
    DiffText = { bg = c.diff_text },

    -- ── Messages ────────────────────────────────────────────
    ErrorMsg = { fg = c.error },
    WarningMsg = { fg = c.warning },
    ModeMsg = { fg = c.fg, bold = true },
    MsgArea = { fg = c.fg },
    MoreMsg = { fg = c.blue },
    Question = { fg = c.blue },

    -- ── Spell ───────────────────────────────────────────────
    SpellBad = { sp = c.error, undercurl = true },
    SpellCap = { sp = c.warning, undercurl = true },
    SpellLocal = { sp = c.info, undercurl = true },
    SpellRare = { sp = c.hint, undercurl = true },

    -- ── Status & Tab Line ───────────────────────────────────
    StatusLine = { fg = c.fg_sidebar, bg = c.bg_dark },
    StatusLineNC = { fg = c.dark3, bg = c.bg_dark },
    TabLine = { fg = c.dark5, bg = c.bg_dark },
    TabLineFill = { bg = c.bg_dark },
    TabLineSel = { fg = c.fg, bg = c.bg },
    WinBar = { link = "StatusLine" },
    WinBarNC = { link = "StatusLineNC" },

    -- ── Misc ────────────────────────────────────────────────
    Directory = { fg = c.blue },
    EndOfBuffer = { fg = c.bg },
    NonText = { fg = c.nontext },
    SpecialKey = { fg = c.nontext },
    Whitespace = { fg = c.fg_gutter },
    ColorColumn = { bg = c.bg_highlight },
    Conceal = { fg = c.dark5 },
    MatchParen = { fg = c.orange, bold = true },
    Title = { fg = c.blue, bold = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Underlined = { underline = true },
    QuickFixLine = { bg = c.bg_visual, bold = true },
    WildMenu = { bg = c.bg_visual },
    Todo = { fg = c.bg, bg = c.yellow, bold = true },

    -- ── Diagnostics (signs & text) ──────────────────────────
    DiagnosticError = { fg = c.error },
    DiagnosticWarn = { fg = c.warning },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },
    DiagnosticUnnecessary = { fg = c.dark5 },
    DiagnosticVirtualTextError = { fg = c.error, bg = c.virt_error },
    DiagnosticVirtualTextWarn = { fg = c.warning, bg = c.virt_warning },
    DiagnosticVirtualTextInfo = { fg = c.info, bg = c.virt_info },
    DiagnosticVirtualTextHint = { fg = c.hint, bg = c.virt_hint },
    DiagnosticUnderlineError = { sp = c.error, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.warning, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },
  }
end

return M
