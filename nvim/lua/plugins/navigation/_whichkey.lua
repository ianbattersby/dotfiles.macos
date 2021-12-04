local function config()
	require("which-key").setup({})
end

return {
	setup = function(use)
		use({
			"folke/which-key.nvim",
			config = config,
		})
	end,
}
