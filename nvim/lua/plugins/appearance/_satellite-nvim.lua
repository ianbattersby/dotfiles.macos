local function config()
  require("satellite").setup {
    handlers = {
      search = {
        enable = true,
        overlap = true,
        priority = 10,
      },
      diagnostic = {
        enable = true,
        overlap = true,
        priority = 50,
      },
      gitsigns = {
        enable = false,
        overlap = false,
        priority = 20,
      },
      marks = {
        key = "m",
        enable = true,
        overlap = true,
        priority = 60,
        show_builtins = false,
      },
    },
    current_only = false,
    winblend = 50,
    zindex = 40,
    excluded_filetypes = {},
  }
end

return {
  setup = function(use)
    use {
      "lewis6991/satellite.nvim",
      config = config,
    }
  end,
}
