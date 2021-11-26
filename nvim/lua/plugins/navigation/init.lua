return {
  setup = function(use)
    require'plugins.navigation.telescope'.setup(use)
    require'plugins.navigation.nvim-tree'.setup(use)
    require'plugins.navigation.tmux-navigator'.setup(use)
    require'plugins.navigation.lightspeed'.setup(use)
    require'plugins.navigation.numb'.setup(use)
  end
}
