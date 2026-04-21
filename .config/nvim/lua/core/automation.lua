-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LSP format-on-save for filetypes where an LSP owns formatting.
-- ALE handles Python + "*" globals (trim whitespace, trailing lines).
local lsp_format_filetypes = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  css = true,
  scss = true,
  less = true,
  json = true,
  jsonc = true,
  toml = true,
  lua = true,
  svelte = true,
  vue = true,
  astro = true,
}

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'LSP format on save for allowlisted filetypes',
  group = vim.api.nvim_create_augroup('user-lsp-format-on-save', { clear = true }),
  callback = function(args)
    if not lsp_format_filetypes[vim.bo[args.buf].filetype] then
      return
    end
    vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000 })
  end,
})
