local function config()
  require("hlslens").setup {}
  require("scrollbar.handlers.search").setup()
end

return {
  setup = function(use)
    use {
      "kevinhwang91/nvim-hlslens",
      after = "nvim-scrollbar",
      config = config,
    }
  end,
}
