return {
  "dense-analysis/ale",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Disable ALE's LSP features; nvim-lspconfig handles LSP
    vim.g.ale_disable_lsp = 1

    -- Only run explicitly configured linters
    vim.g.ale_linters_explicit = 1

    -- Linters: Biome LSP owns JS/TS/CSS/JSON/TOML diagnostics; ALE only lints Python
    vim.g.ale_linters = {
      python = { "pylint" },
    }

    -- Fixers: biome LSP + stylua LSP handle their own filetypes via BufWritePre (see core/automation.lua)
    vim.g.ale_fixers = {
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      python = { "isort", "black" },
    }

    -- Fix on save (applies only to filetypes above — "*" globals + python)
    vim.g.ale_fix_on_save = 1

    -- Python options
    vim.g.ale_python_auto_virtualenv = 1
    vim.g.ale_python_pylint_options = "--max-line-length=100"
    vim.g.ale_python_flake8_options = "--max-line-length=100"

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
