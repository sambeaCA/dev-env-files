local wk = require("which-key")
local keymap = vim.keymap
local todo_comments = require("todo-comments")

-- Group registrations (single source of truth)
wk.add({
  { "<leader>b", group = "Buffer" },
  { "<leader>c", group = "Code (LSP)" },
  { "<leader>e", group = "Explorer (NvimTree)" },
  { "<leader>F", group = "File Ops (force)" },
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>g", group = "LazyGit" },
  { "<leader>h", group = "GitSigns" },
  { "<leader>l", group = "Lint (ALE)" },
  { "<leader>m", group = "Format" },
  { "<leader>n", group = "Todo-Comments" },
  { "<leader>s", group = "Split Window" },
  { "<leader>t", group = "Tabs" },
  { "<leader>u", group = "Substitute" },
  { "<leader>w", group = "Window / Session" },
  { "<leader>x", group = "Trouble (Diagnostics)" },
})

-- Buffer ops
keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>", { desc = "Close buffer" })

-- Window / Session save
keymap.set("n", "<leader>ww", "<cmd>w!<CR>", { desc = "Save file" })
keymap.set("n", "<leader>wc", "<cmd>Bdelete<CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical (VSCode-style)" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontal (VSCode-style)" })

-- Splits (legacy <leader>s prefix)
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })

-- File ops (force) — capital F to free <leader>f for Telescope
keymap.set("n", "<leader>Fw", "<cmd>w!<CR>", { desc = "Force write" })
keymap.set("n", "<leader>Fq", "<cmd>q!<CR>", { desc = "Force quit" })
keymap.set("n", "<leader>Fx", "<cmd>x<CR>", { desc = "Write and quit" })
keymap.set("n", "<leader>Fn", function()
  vim.ui.input({ prompt = "New file: ", completion = "file" }, function(name)
    if not name or name == "" then
      return
    end
    local path = vim.fn.fnamemodify(name, ":p")
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    vim.cmd.edit(path)
    vim.cmd.write()
  end)
end, { desc = "New file (prompt for path)" })
keymap.set("n", "<leader>FN", function()
  vim.cmd.enew()
  vim.bo.bufhidden = "wipe"
end, { desc = "New scratch buffer" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Format
keymap.set("n", "<leader>mp", "<cmd>ALEFix<CR>", { desc = "Format file (ALE)" })
keymap.set("v", "<leader>mp", function()
  vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
end, { desc = "Format selection (LSP)" })

-- LazyGit
keymap.set("n", "<leader>go", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Substitute (sniprun reserves <leader>r)
keymap.set("n", "<leader>u", require("substitute").operator, { desc = "Substitute with motion" })
keymap.set("n", "<leader>uu", require("substitute").line, { desc = "Substitute line" })
keymap.set("n", "<leader>U", require("substitute").eol, { desc = "Substitute to end of line" })
keymap.set("x", "<leader>u", require("substitute").visual, { desc = "Substitute in visual mode" })

-- Todo navigation
keymap.set("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })
keymap.set("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })
keymap.set("n", "<leader>nt", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })

-- VSCode-style comment toggle
keymap.set("n", "<leader>/", function()
  return vim.api.nvim_get_mode().mode == "n" and "gcc" or "gc"
end, { expr = true, remap = true, desc = "Toggle comment" })
keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment (visual)" })

-- Jump to matching bracket (VSCode: gmb)
keymap.set("n", "gmb", "%", { desc = "Jump to matching bracket" })
