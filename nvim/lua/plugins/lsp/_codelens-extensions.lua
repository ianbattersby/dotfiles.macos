local function config()
  require("codelens_extensions").setup {
    vertical_split = false,
    rust_debug_adapter = "rt_lldb",
    init_rust_commands = true,
  }
end

return {
  setup = function(use)
    use {
      "ericpubu/lsp_codelens_extensions.nvim",
      requires = { { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" } },
      after = { "nvim-lspconfig", "nvim-dap" },
      config = config,
    }
  end,
}
