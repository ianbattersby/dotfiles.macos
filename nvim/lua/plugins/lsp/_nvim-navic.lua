local function config()
  require("nvim-navic").setup { depth_limit = 2, highlight = true }
end

return {
  setup = function(use)
    use {
      "SmiteshP/nvim-navic",
      requires = { "neovim/nvim-lspconfig" },
      config = config,
    }
  end,
}
