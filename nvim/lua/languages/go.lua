local settings = {
	cmd = { "/opt/Homebrew/bin/gopls" },
}

return { name = "go", server = "gopls", config = { settings = settings } }
