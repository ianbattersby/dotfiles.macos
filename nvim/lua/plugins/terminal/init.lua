return {
  setup = function(use)
    require("plugins.terminal._fugitive").setup(use)
    require("plugins.terminal._toggleterm-nvim").setup(use)
    require("plugins.terminal._nvim-unception").setup(use)
  end,
}
