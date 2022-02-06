local function config()
  require("surround").setup { mappings_style = "surround" }
end

return {
  setup = function(use)
    use {
      "blackCauldron7/surround.nvim",
      config = config,
    }
  end,
}
