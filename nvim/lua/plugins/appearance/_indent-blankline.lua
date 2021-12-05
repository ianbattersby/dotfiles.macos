local function config()
	vim.opt.list = true
	vim.opt.listchars:append("space:⋅")
	vim.opt.listchars:append("tab:⋅→")
	--vim.opt.listchars:append("eol:↴")

	require("indent_blankline").setup({
		buftype_exclude = { "terminal", "telescope", "nofile" },
		filetype_exclude = { "help", "alpha", "packer", "NvimTree", "Trouble" },
		space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = false,
		use_treesitter = true,
	})
end

return {
	setup = function(use)
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = config,
		})
	end,
}
