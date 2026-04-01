return {
  "dense-analysis/ale",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Disable ALE's LSP features; nvim-lspconfig handles LSP
    vim.g.ale_disable_lsp = 1

    -- Only run explicitly configured linters
    vim.g.ale_linters_explicit = 1

    -- Linters: Biome LSP handles JS/TS diagnostics, ALE only lints Python
    vim.g.ale_linters = {
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      svelte = {},
      python = { "pylint" },
      css = { "biome" },
      lua = {},
      toml = { "biome" },
      json = { "biome" },
    }

    -- Map JSX/TSX filetypes to JS/TS for fixer resolution
    vim.g.ale_linter_aliases = {
      javascriptreact = { "javascript" },
      typescriptreact = { "typescript" },
    }

    -- Fixers
    vim.g.ale_fixers = {
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      svelte = { "biome" },
      python = { "isort", "black" },
      css = { "biome" },
      lua = { "stylua" },
      toml = { "biome" },
      json = { "biome" },
    }

    -- Fix on save
    vim.g.ale_fix_on_save = 1

    -- Lint timing
    vim.g.ale_lint_on_text_changed = "normal"
    vim.g.ale_lint_on_insert_leave = 1
    vim.g.ale_lint_on_enter = 1
    vim.g.ale_lint_on_save = 1

    -- Sign column symbols
    vim.g.ale_sign_error = ""
    vim.g.ale_sign_warning = ""
    vim.g.ale_sign_info = ""

    -- Virtual text
    vim.g.ale_virtualtext_cursor = "current"

    -- Keymaps
    vim.keymap.set("n", "<leader>l", "<cmd>ALELint<CR>", { desc = "Trigger linting (ALE)" })
  end,
}
