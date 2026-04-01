return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      active = true,
      on_config_done = nil,
      keymap = {
        normal_mode = {},
      },
      highlights = {
        background = {
          italic = true,
        },
        buffer_selected = {
          bold = true,
        },
      },
      mode = "buffers",
      numbers = "ordinal",
      auto_toggle_bufferline = true,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      hover = {
        enabled = true, -- requires nvim 0.8+
        delay = 200,
        reveal = { "close" },
      },
      sort_by = "id",
      debug = { logging = false },
    },
  },
}
