return {
	setup = function(use)
		require("plugins.navigation._lightspeed").setup(use)
		require("plugins.navigation._numb").setup(use)
		require("plugins.navigation._nvim-tree").setup(use)
		require("plugins.navigation._telescope").setup(use)
		require("plugins.navigation._tmux-navigator").setup(use)
		require("plugins.navigation._whichkey").setup(use)
	end,
}
