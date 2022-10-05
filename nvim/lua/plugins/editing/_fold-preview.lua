local function config()
  require("fold-preview").setup {}
end

return {
  setup = function(use)
    use {
      "anuvyklack/fold-preview.nvim",
      requires = "anuvyklack/nvim-keymap-amend",
      after = "pretty-fold.nvim",
      config = config,
    }
  end,
}
