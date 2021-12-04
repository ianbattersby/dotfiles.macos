local function config()
	require("lualine").setup({
		options = {
			icones_enabled = true,
			theme = require("plugins.appearance._theme").name,
			componentseparators = { "", "" },
			section_separators = { "", "" },
			extensions = { "fzf" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "filename" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabnine = {},
	})
end

return {
	setup = function(use)
		use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = config,
		})
	end,
}
