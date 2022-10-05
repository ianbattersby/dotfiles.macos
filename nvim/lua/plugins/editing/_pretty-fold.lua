local function config()
  require("pretty-fold").setup {}
end

return {
  setup = function(use)
    use {
      "anuvyklack/pretty-fold.nvim",
      requires = "anuvyklack/nvim-keymap-amend",
      config = config,
    }
  end,
}
