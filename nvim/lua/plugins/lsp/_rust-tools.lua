local function config()
  require("rust-tools").setup {
    -- debugging stuff
    tools = {
      runnables = { use_telescope = true },
      inlay_hints = { auto = false }, --{ show_parameter_hints = true },
      hover_actions = { auto_focus = true },
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(
        table.concat({ vim.fn.stdpath "data", "mason", "packages", "codelldb", "codelldb" }, "/"),
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
        { "neovim/nvim-lspconfig" },
      },
      after = "nvim-dap",
      config = config,
    }
  end,
}
