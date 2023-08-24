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
    }
  }
}
