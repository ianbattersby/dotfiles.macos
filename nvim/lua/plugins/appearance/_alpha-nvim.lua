local function config()
  require("alpha").setup(require("alpha.themes.startify").opts)
end

return {
  setup = function(use)
    use {
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      after = { "onedark.nvim", "nvim-web-devicons" },
      config = config,
    }
  end,
}
