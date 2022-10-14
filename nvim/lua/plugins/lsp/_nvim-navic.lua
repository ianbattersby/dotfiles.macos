local function config()
  require("nvim-navic").setup { depth_limit = 3 }
end

return {
  setup = function(use)
    use {
      "SmiteshP/nvim-navic",
      requires = { "neovim/nvim-lspconfig" },
      after = { "nvim-lspconfig" },
      config = config,
    }
  end,
}
