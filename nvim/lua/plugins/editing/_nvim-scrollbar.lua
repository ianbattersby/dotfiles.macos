local function config()
  require("scrollbar").setup()
end

return {
  setup = function(use)
    use {
      "petertriho/nvim-scrollbar",
      config = config,
    }
  end,
}
