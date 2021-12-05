local function config()
	require("rust-tools").setup({
		-- debugging stuff
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(
				"/Users/ian/.local/codelldb-aarch64-darwin/extension/adapter/codelldb",
				"/Users/ian/.local/codelldb-aarch64-darwin/extension/lldb/lib/liblldb.dylib"
			),
		},
	})
end

return {
	setup = function(use)
		use({
			"simrat39/rust-tools.nvim",
			requires = {
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
			config = config,
		})
	end,
}
