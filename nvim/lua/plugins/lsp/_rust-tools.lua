local function config()
  require("rust-tools").setup {
    -- debugging stuff
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(
        table.concat(
          { vim.fn.stdpath "data", "mason", "packages", "codelldb", "extension", "lldb", "bin", "codelldb" },
          "/"
        ),
        table.concat(
          { vim.fn.stdpath "data", "mason", "packages", "codelldb", "extension", "lldb", "lib", "liblldb.dylib" },
          "/"
        )
      ),
    },
  }

  require("rust-tools.dap").setup_adapter()
end

return {
  setup = function(use)
    use {
      "simrat39/rust-tools.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "mfussenegger/nvim-dap" },
      },
      after = "nvim-dap",
      config = config,
    }
  end,
}
