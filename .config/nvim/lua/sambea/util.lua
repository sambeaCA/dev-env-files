local M = {}

--- Convert a hex color string to RGB components
---@param hex string "#RRGGBB"
---@return number, number, number
function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

--- Convert RGB components to hex color string
---@param r number
---@param g number
---@param b number
---@return string "#RRGGBB"
function M.rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

--- Blend two hex colors together
---@param fg string foreground hex color
---@param alpha number blend factor (0.0 = all bg, 1.0 = all fg)
---@param bg string background hex color
---@return string blended hex color
function M.blend(fg, alpha, bg)
  local fr, fg_, fb = M.hex_to_rgb(fg)
  local br, bg_, bb = M.hex_to_rgb(bg)
  return M.rgb_to_hex(
    fr * alpha + br * (1 - alpha),
    fg_ * alpha + bg_ * (1 - alpha),
    fb * alpha + bb * (1 - alpha)
  )
end

--- Darken a hex color by blending toward black
---@param hex string color to darken
---@param amount number 0.0 = unchanged, 1.0 = pure black
---@return string
function M.darken(hex, amount)
  return M.blend("#000000", amount, hex)
end

--- Lighten a hex color by blending toward white
---@param hex string color to lighten
---@param amount number 0.0 = unchanged, 1.0 = pure white
---@return string
function M.lighten(hex, amount)
  return M.blend("#ffffff", amount, hex)
end

return M
