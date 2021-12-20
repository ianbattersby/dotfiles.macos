local function config()
  require("nvim-gps").setup()
end

return {
  setup = function(use)
    use {
      "SmiteshP/nvim-gps",
      requires = {
        { "nvim-treesitter/nvim-treesitter" },
      },
      config = config,
    }
  end,
}
