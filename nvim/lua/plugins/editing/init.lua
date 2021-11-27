return {
  setup = function(use)
    require'plugins.editing._comment'.setup(use)
    require'plugins.editing._highlight'.setup(use)
    require'plugins.editing._nvim-autopairs'.setup(use)
    require'plugins.editing._textobj'.setup(use)
    require'plugins.editing._vim-strip-trailing-whitespace'.setup(use)
  end
}
