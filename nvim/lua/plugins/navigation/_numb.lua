local function config()
	require("numb").setup()
end

return {
	setup = function(use)
		use({
			"nacro90/numb.nvim",
			config = config,
		})
	end,
}
