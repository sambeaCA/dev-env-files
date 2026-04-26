return {
  settings = {
    evenBetterToml = {
      schema = {
        enabled = true,
        catalogs = { "https://www.schemastore.org/api/json/catalog.json" },
      },
      formatter = {
        alignEntries = false,
        alignComments = true,
        arrayTrailingComma = true,
        arrayAutoExpand = true,
        compactArrays = false,
        columnWidth = 100,
      },
    },
  },
}
