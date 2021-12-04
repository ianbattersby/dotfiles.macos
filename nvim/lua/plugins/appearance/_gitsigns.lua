local function config()
	require("gitsigns").setup({
		signcolumn = true,
		linehl = true,
		trouble = true,
	})
end

return {
	setup = function(use)
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			config = config,
		})
	end,
}
