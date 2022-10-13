local function config()
  require("noice").setup()
end

return {
  setup = function(use)
    use {
      "folke/noice.nvim",
      event = "VimEnter",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = config,
    }
  end,
}
