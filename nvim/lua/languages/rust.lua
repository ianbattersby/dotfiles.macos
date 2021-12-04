local settings = {
	["rust-analyzer"] = {
		assist = {
			importMergeBehavior = "last",
			importPrefix = "by_self",
		},
		cargo = {
			loadOutDirsFromCheck = true,
		},
		procMacro = {
			enable = true,
		},
	},
}

return { name = "rust", server = "rust_analyzer", config = { settings = settings } }
