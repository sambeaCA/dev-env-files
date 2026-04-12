-- Set keymap to local variable
local wk = require("which-key")
local keymap = vim.keymap
local api = vim.api
local todo_comments = require("todo-comments")

-- Buffer close (VSCode-style)
wk.add({
  { "<leader>x", desc = "Close buffer" },
})

-- Session Manager
wk.add({
  { "<leader>w", group = "Session Manager" },
})
keymap.set("n", "<leader>ww", "<cmd>w!<CR>", { desc = "Save file" })
keymap.set("n", "<leader>wc", "<cmd>Bdelete<CR>", { desc = "Close buffer" })
keymap.set("n", "<leader>x", "<cmd>Bdelete<CR>", { desc = "Close buffer" })
-- window management
wk.add({
  { "<leader>s", group = "Split Window" },
})
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" }) -- Maximize window

-- VSCode-style split aliases
wk.add({
  { "<leader>w", group = "Session Manager / Splits" },
})
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical (VSCode-style)" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontal (VSCode-style)" })

-- VSCode-style file ops
wk.add({
  { "<leader>f", group = "File Ops / Find" },
})
keymap.set("n", "<leader>fw", "<cmd>w!<CR>", { desc = "Force write" })
keymap.set("n", "<leader>fq", "<cmd>q!<CR>", { desc = "Force quit" })
keymap.set("n", "<leader>fx", "<cmd>x<CR>", { desc = "Write and quit" })

-- Jump to matching bracket (VSCode: gmb)
keymap.set("n", "gmb", "%", { desc = "Jump to matching bracket" })

-- Tabs management
wk.add({
  { "<leader>t", group = "Tabs Management" },
})
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Formating
wk.add({
  { "<leader>m", group = "Formating" },
})
keymap.set("n", "<leader>mp", "<cmd>ALEFix<CR>", { desc = "Format file (ALE)" })
keymap.set("v", "<leader>mp", function()
  vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
end, { desc = "Format selection (LSP)" })

-- GitSigns

wk.add({
  { "<leader>h", group = "GitSigns" },
})

-- LazyGit
wk.add({
  { "<leader>g", group = "LazyGit" },
})

-- Claude Code
wk.add({
  { "<leader>a", group = "AI/Claude Code" },
})
keymap.set("n", "<leader>go", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Substitute / Run
wk.add({
  { "<leader>r", group = "Substitute / Run" },
})
keymap.set("n", "<leader>r", require("substitute").operator, { desc = "Substitute with motion" })
keymap.set("n", "<leader>rr", require("substitute").line, { desc = "Substitute line" })
keymap.set("n", "<leader>R", require("substitute").eol, { desc = "Substitute to end of line" })
keymap.set("x", "<leader>r", require("substitute").visual, { desc = "Substitute in visual mode" })

-- Todo Comments
wk.add({
  { "<leader>n", group = "Todo-Comments" },
})
keymap.set("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })

keymap.set("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })
