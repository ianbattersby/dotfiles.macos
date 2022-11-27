local function config()
  -- Moved to language/rust.lua.initialize()
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
      config = config,
    }
  end,
}
