if vim.fn.has 'nvim-0.9.0' == 0 then
  vim.api.nvim_echo({
    { 'LazyVim requires Neovim >= 0.9.0\n', 'ErrorMsg' },
    { 'Press any key to exit', 'MoreMsg' },
  }, true, {})
  vim.fn.getchar()
  vim.cmd [[quit]]
  return {}
end

return {
  'nvim-lua/plenary.nvim', -- lua functions that many plugin use
  'christoomey/vim-tmux-navigator', -- tmux & split window navigation
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
}
