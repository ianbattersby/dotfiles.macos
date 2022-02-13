local function config()
  require("hlslens").setup {}
end

return {
  setup = function(use)
    use {
      "kevinhwang91/nvim-hlslens",
      config = config,
    }
  end,
}
