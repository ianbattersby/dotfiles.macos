local function config()
	local null_ls = require("null-ls")

	null_ls.config({
		sources = {
			null_ls.builtins.formatting.prettier.with({
				filetypes = { "html", "markdown" },
			}),
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.terraform_fmt,
			null_ls.builtins.code_actions.eslint,
			null_ls.builtins.code_actions.shellcheck,
			null_ls.builtins.diagnostics.pylint,
		},
	})
end

return {
	setup = function(use)
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "neovim/nvim-lspconfig"},
			},
			config = config,
		})
	end,
}
