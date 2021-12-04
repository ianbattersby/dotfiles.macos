local function config()
	vim.g.ultest_use_pty = 1
	vim.g["test#strategy"] = { nearest = "vimux", file = "vimux", suite = "vimux" }
	vim.g["test#enabled_runner"] = { "python#pytest", "go#gotest", "lua#busted", "rust#cargotest" }
	vim.g["VimuxHeight"] = 40
	vim.g["VimuxUseNearest"] = 1
	vim.g["VimuxOrientation"] = "h"
	vim.g["VimuxRunnerName"] = "vm-test"
	vim.g["VimuxCloseOnExit"] = 1
end

return {
	setup = function(use)
		use({
			"rcarriga/vim-ultest",
			requires = { { "vim-test/vim-test" }, { "preservim/vimux" } },
			run = ":UpdateRemotePlugins",
			config = config,
		})
	end,
}
