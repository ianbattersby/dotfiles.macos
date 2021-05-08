return {
  setup = function(use)
    require'plugins.linting.ale'.setup(use)
    require'plugins.linting.vim-terraform'.setup(use)
  end
}
