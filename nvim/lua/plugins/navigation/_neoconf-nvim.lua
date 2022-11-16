return {
  setup = function(use)
    use {
      "folke/neoconf.nvim",
      module = "neoconf",
      config = function()
        require("neoconf").setup()
      end,
    }
  end,
}
