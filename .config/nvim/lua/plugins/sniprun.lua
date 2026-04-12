return {
  "michaelb/sniprun",
  branch = "master",

  build = "sh install.sh",
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  keys = {
    { "<leader>rc", "<Plug>SnipRun", mode = { "n", "v" }, desc = "Run code (SnipRun)" },
    { "<leader>ro", "<Plug>SnipRunOperator", mode = "n", desc = "Run with motion (SnipRun)" },
    { "<leader>rx", "<cmd>SnipClose<CR><cmd>SnipReset<CR>", mode = "n", desc = "Close & reset SnipRun" },
  },

  config = function()
    require("sniprun").setup({
      selected_interpreters = { "Python3_fifo" },
      repl_enable = { "Python3_fifo" },
      interpreter_options = {
        Python3_fifo = {
          venv = { ".venv" },
        },
      },
      display = {
        -- "Classic", --# display results in the command-line  area
        "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
        "Terminal", --# display results in a vertical split
      },
    })
  end,
}
