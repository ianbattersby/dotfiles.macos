return {
  setup = function(use)
    require'plugins.navigation.nvim-tree'.setup(use)
    require'plugins.navigation.tmux-navigator'.setup(use)
    require'plugins.navigation.vim-sneak'.setup(use)
  end
}
