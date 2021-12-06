local config = {
	settings = {
		python = {
			autoSearchPaths = true,
			diagnosticMode = "workspace",
			useLibraryCodeForTypes = true,
		},
	},
}

return { server = "pyright", config = config }
