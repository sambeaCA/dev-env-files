return {
  filetypes = { "terraform", "terraform-vars", "hcl" },
  settings = {
    ["terraform-ls"] = {
      experimentalFeatures = {
        validateOnSave = true,
        prefillRequiredFields = true,
      },
      indexing = {
        ignoreDirectoryNames = { ".terraform", ".git", "node_modules" },
      },
      terraform = {
        timeout = "30s",
      },
    },
  },
}
