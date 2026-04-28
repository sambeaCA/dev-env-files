return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { [[<M-\>]], mode = { "n", "t" }, desc = "Toggle terminal" },
  },
  opts = {
    open_mapping = [[<M-\>]],
    direction = "float",
    start_in_insert = true,
    insert_mappings = false,
    terminal_mappings = true,
    float_opts = {
      border = "curved",
      winblend = 3,
    },
  },
}
