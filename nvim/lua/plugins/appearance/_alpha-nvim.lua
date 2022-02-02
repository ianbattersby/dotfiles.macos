local function config()
  require("alpha").setup(require("alpha.themes.startify").opts)

  require("which-key").register({
    a = { ":Alpha<CR>", "Show (Workspace)" },
  }, { prefix = "<leader>" })
end

return {
  setup = function(use)
    use {
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      after = { "onedark.nvim", "nvim-web-devicons", "which-key.nvim" },
      config = config,
    }
  end,
}
