return {
  server = "yamlls",
  config = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
    schemas = {
      ["https://json.schemastore.org/chart.json"] = "/deployment/helm/*",
      ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
    },
  }
}
