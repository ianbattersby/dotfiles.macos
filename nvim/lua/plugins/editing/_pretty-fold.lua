local function config()
  require("pretty-fold").setup {}
  require("pretty-fold.preview").setup_keybinding "l"
end

return {
  setup = function(use)
    use {
      "anuvyklack/pretty-fold.nvim",
      config = config,
    }
  end,
}
