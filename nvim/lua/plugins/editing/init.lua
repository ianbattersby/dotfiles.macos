return {
  setup = function(use)
    require'plugins.editing.comment'.setup(use)
    require'plugins.editing.highlight'.setup(use)
    require'plugins.editing.textobj'.setup(use)
  end
}
