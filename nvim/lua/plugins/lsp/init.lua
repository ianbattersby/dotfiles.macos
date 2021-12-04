return {
	setup = function(use)
		require("plugins.lsp._null-ls").setup(use)
		require("plugins.lsp._nvim-cmp").setup(use)
		require("plugins.lsp._lspconfig").setup(use)
		require("plugins.lsp._lsputils").setup(use)
		require("plugins.lsp._trouble").setup(use)
		require("plugins.lsp._treesitter").setup(use)
		require("plugins.lsp._vim-ultest").setup(use)
		require("plugins.lsp._nvim-dap").setup(use)
	end,
}
