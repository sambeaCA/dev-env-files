return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>t", desc = "Toggle terminal" },
  },
  opts = {
    open_mapping = [[<leader>t]],
    direction = "float",
    start_in_insert = true,
    insert_mappings = false, -- no mapping in insert mode (leader doesn't apply)
    terminal_mappings = true, -- <leader>t works from inside the terminal
    float_opts = {
      border = "curved",
      winblend = 3,
    },
  },
}
