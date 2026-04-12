local util = require("sambea.util")
local blend = util.blend

--- Sambea brand palette + derived helper colors
---@class SambeaPalette
local c = {}

-- ── Brand Colors ──────────────────────────────────────────────
c.brand_green = "#A8F176" -- Primary: Light Green
c.brand_hunter = "#3A6A4F" -- Secondary: Hunter Green
c.brand_dust = "#D7D3CC" -- Accent: Dust Grey
c.brand_snow = "#F6F6F6" -- Light: Bright Snow
c.brand_shadow = "#221D1E" -- Dark: Shadow Grey

-- ── Backgrounds ───────────────────────────────────────────────
c.bg = "#221D1E"
c.bg_dark = "#1A1516"
c.bg_highlight = "#2E2829"
c.bg_visual = "#3A3235"
c.bg_search = "#4A6A3F"
c.bg_popup = "#1A1516"
c.fg_gutter = "#3D3839"
c.terminal_black = "#4A4546"
c.border = "#3D3839"
c.border_highlight = "#5E9A6B"

-- ── Foregrounds ───────────────────────────────────────────────
c.fg = "#E8E4DF"
c.fg_dark = "#D7D3CC"
c.fg_sidebar = "#D7D3CC"
c.comment = "#5E8A6B"
c.dark3 = "#6B6666"
c.dark5 = "#8A8585"
c.nontext = "#4A4546"

-- ── Syntax Colors ─────────────────────────────────────────────
c.green = "#A8F176"
c.green1 = "#73DCA0"
c.green2 = "#3A9A6F"
c.blue = "#7AA8D4"
c.blue1 = "#5AC8D4"
c.blue5 = "#89C8E8"
c.cyan = "#6ECFCF"
c.teal = "#1ABC9C"
c.purple = "#B894E8"
c.magenta = "#D490D4"
c.magenta2 = "#E8307A"
c.orange = "#E8A864"
c.yellow = "#E8D06A"
c.red = "#E86A7A"
c.red1 = "#D44B5B"

-- ── Diagnostics ───────────────────────────────────────────────
c.error = "#D44B5B"
c.warning = "#E8D06A"
c.info = "#5AC8D4"
c.hint = "#1ABC9C"

-- ── Git ───────────────────────────────────────────────────────
c.git_add = "#3A9A6F"
c.git_change = "#5A8ABB"
c.git_delete = "#9A4C5A"
c.git_ignore = "#6B6666"

-- ── Diff (blended over bg) ────────────────────────────────────
c.diff_add = blend("#3A9A6F", 0.25, c.bg)
c.diff_delete = blend("#D44B5B", 0.25, c.bg)
c.diff_change = blend("#4A6A8A", 0.15, c.bg)
c.diff_text = blend("#4A6A8A", 0.35, c.bg)

-- ── Diagnostic Virtual Text (tinted backgrounds) ──────────────
c.virt_error = blend(c.error, 0.12, c.bg)
c.virt_warning = blend(c.warning, 0.12, c.bg)
c.virt_info = blend(c.info, 0.12, c.bg)
c.virt_hint = blend(c.hint, 0.12, c.bg)

-- ── Terminal Colors (ANSI 16) ─────────────────────────────────
c.terminal = {
  black = "#1A1516",
  red = "#E86A7A",
  green = "#A8F176",
  yellow = "#E8D06A",
  blue = "#7AA8D4",
  magenta = "#D490D4",
  cyan = "#6ECFCF",
  white = "#D7D3CC",
  bright_black = "#4A4546",
  bright_red = "#F08A9A",
  bright_green = "#C0FF96",
  bright_yellow = "#F0E08A",
  bright_blue = "#9AC0E8",
  bright_magenta = "#E8A8E8",
  bright_cyan = "#8EE0E0",
  bright_white = "#E8E4DF",
}

-- ── Rainbow (markdown headings, brackets) ─────────────────────
c.rainbow = {
  c.blue,
  c.yellow,
  c.green,
  c.teal,
  c.magenta,
  c.purple,
  c.orange,
  c.red,
}

return c
