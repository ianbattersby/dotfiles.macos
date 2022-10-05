local function config()
  require("trouble").setup {
    position = "bottom",
    height = 10,
    auto_open = false,
    auto_close = true,
  }
end

return {
  setup = function(use)
    use {
      "folke/trouble.nvim",
      requires = {
        { "kyazdani42/nvim-web-devicons" },
      },
      config = config,
    }
  end,
}
