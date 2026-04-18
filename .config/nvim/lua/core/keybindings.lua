-- Set keymap to local variable
local keymap = vim.keymap

local api = vim.api

api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Navigate out of terminal mode directly into a pane (no need to <Esc><Esc> first)
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left pane from terminal" })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to pane below from terminal" })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to pane above from terminal" })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right pane from terminal" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Remap enter to make a new line below curson (macOS) in normal mode
api.nvim_set_keymap("n", "<CR>", "o<ESC>", { noremap = true, silent = true })

-- Shift+Enter: open new line below and enter insert mode (VSCode-style)
api.nvim_set_keymap("n", "<S-CR>", "o", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<S-CR>", "<Esc>o", { noremap = true, silent = true })

-- Navigate to next buffer
api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- Jump to buffer by ordinal position (VSCode Ctrl+1–9)
for i = 1, 9 do
  keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end

-- VSCode-compatible keybindings
-- Window/pane navigation (mirrors VSCode pane focus keys)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left pane" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus pane below" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus pane above" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right pane" })

-- Move lines (mirrors Alt+j/k in VSCode)
keymap.set("n", "<leader>mj", ":m .+1<CR>==", { desc = "Move line down", silent = true })
keymap.set("n", "<leader>mk", ":m .-2<CR>==", { desc = "Move line up", silent = true })
keymap.set("v", "<leader>mj", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "<leader>mk", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Duplicate lines (mirrors Shift+Alt+j/k in VSCode)
keymap.set("n", "<leader>dj", "yyp", { desc = "Duplicate line down" })
keymap.set("n", "<leader>dk", "yyP", { desc = "Duplicate line up" })
-- Duplicate selection down
keymap.set("v", "<leader>dj", "yp", { desc = "Duplicate selection down" })
-- Duplicate selection up
keymap.set("v", "<leader>dk", "yP", { desc = "Duplicate selection up" })
-- Note: Visual duplication is trickier; usually, people just use 'y' then 'p'.
-- Visual indent stays in visual mode (mirrors < > in VSCode visual)
keymap.set("v", "<", "<gv", { desc = "Outdent and stay in visual" })
keymap.set("v", ">", ">gv", { desc = "Indent and stay in visual" })
