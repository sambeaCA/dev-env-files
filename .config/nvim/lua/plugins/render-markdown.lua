return {
  "MeanderingProgrammer/render-markdown.nvim", --render-markdown.nvim is an optional dependency that is used to render the markdown content of the chat history.
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { "markdown", "Avante" },
    completions = {
      lsp = { enabled = true },
    },
    latex = {
      enabled = true,
      converter = "latex2text",
    },
    heading = {
      sign = false,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      width = "block",
      left_pad = 0,
      right_pad = 2,
    },
    code = {
      style = "full",
      position = "left",
      width = "block",
      left_pad = 1,
      right_pad = 2,
      border = "thin",
    },
    bullet = {
      icons = { "●", "○", "◆", "◇" },
    },
    checkbox = {
      enabled = true,
    },
    pipe_table = {
      style = "full",
      cell = "padded",
    },
    quote = {
      repeat_linebreak = true,
    },
    anti_conceal = { enabled = true },
  },
  ft = { "markdown", "Avante" },
}
