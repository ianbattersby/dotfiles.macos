local settings = {
  python = {
    autoSearchPaths = true,
    diagnosticMode = "workspace",
    useLibraryCodeForTypes = true
  }
}

return {name = "python", server = "pyright", config = {settings = settings}}
