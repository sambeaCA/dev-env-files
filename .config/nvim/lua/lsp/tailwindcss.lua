return {
  filetypes = {
    "html", "css", "scss", "sass", "postcss",
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "svelte", "vue", "astro",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.ts",
    "package.json",
    "node_modules",
    ".git",
  },
  settings = {
    tailwindCSS = {
      validate = true,
      classFunctions = { "cva", "cn", "clsx", "tw" },
    },
  },
}
