return {
  setup = function(use)
    require("plugins.appearance._alpha-nvim").setup(use)
    require("plugins.appearance._bufferline").setup(use)
    require("plugins.appearance._gitsigns").setup(use)
    require("plugins.appearance._indent-blankline").setup(use)
    require("plugins.appearance._lualine").setup(use)
    require("plugins.appearance._theme").setup(use)
    require("plugins.appearance._nvim-notify").setup(use)
  end,
}
