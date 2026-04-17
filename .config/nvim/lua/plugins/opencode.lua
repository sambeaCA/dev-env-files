local keymap = vim.keymap
return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },

  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    --
    -- keymap.set("n", "<leader>a", nil, { desc = "AI/Open Code" })
    keymap.set("n", "<leader>aa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })
    keymap.set("n", "<leader>ax", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })
    keymap.set("n", "<leader>ac", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })
    keymap.set("n", "<leader>as", function()
      return require("opencode").operator("@this ")
    end, { desc = "Send to opencode", expr = true })
    keymap.set("n", "<leader>ar", function()
      require("opencode").command("session.select")
    end, { desc = "Select A Session" })
    -- keymap.set("n", "goo", function()
    --   return require("opencode").operator("@this ") .. "_"
    -- end, { desc = "Add line to opencode", expr = true })

    -- keymap.set("n", "<S-C-u>", function()
    --   require("opencode").command("session.half.page.up")
    -- end, { desc = "Scroll opencode up" })
    -- keymap.set("n", "<S-C-d>", function()
    --   require("opencode").command("session.half.page.down")
    -- end, { desc = "Scroll opencode down" })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
