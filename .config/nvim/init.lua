-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Lazy.nvim package manager
require("config.lazy")

-- Load core options
require("core")
