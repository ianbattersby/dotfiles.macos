local function config()
  require("nvim-surround").setup {}
end

return {
  setup = function(use)
    use {
      "kylechui/nvim-surround",
      config = config,
    }
  end,
}
