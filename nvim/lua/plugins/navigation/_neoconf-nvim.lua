return {
  setup = function(use)
    use {
      "folke/neoconf.nvim",
      config = function()
        require("neoconf").setup()
      end,
    }
  end,
}
