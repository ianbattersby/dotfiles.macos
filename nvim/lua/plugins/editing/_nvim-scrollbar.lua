local function config()
  require("scrollbar").setup {
    handlers = {
      diagnostic = true,
      search = true,
    },
  }

  require("scrollbar.handlers.search").setup {}
end

return {
  setup = function(use)
    use {
      "petertriho/nvim-scrollbar",
      after = { "nvim-hlslens" },
      config = config,
    }
  end,
}
