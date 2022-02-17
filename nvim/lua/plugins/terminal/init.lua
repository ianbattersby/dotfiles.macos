return {
  setup = function(use)
    require("plugins.terminal._floaterm").setup(use)
    require("plugins.terminal._fugitive").setup(use)
  end,
}
