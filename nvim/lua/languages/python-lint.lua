local config = {
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  },
}

return { server = "ruff_lsp", config = config }
