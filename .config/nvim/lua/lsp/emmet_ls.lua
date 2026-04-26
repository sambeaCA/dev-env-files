return {
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
        ["jsx.enabled"] = true,
      },
    },
    jsx = {
      options = {
        ["markup.attributes"] = {
          ["class"] = "className",
          ["for"] = "htmlFor",
        },
      },
    },
  },
}
