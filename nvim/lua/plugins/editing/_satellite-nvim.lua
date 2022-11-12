local function config()
  require("satellite").setup()
end

return {
  setup = function(use)
    use {
      "lewis6991/satellite.nvim",
      config = config,
    }
  end,
}
