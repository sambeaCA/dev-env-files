return {
  "rcarriga/nvim-notify",
  branch = "master",
  config = function()
    require("notify").setup({
      background_colour = "NotifyBackground",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "wrapped-compact",
      stages = "slide",
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T",
      },
      timeout = 10000,
      top_down = true,
      merge_duplicates = true,
    })
  end,
}
