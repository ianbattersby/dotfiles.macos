return {
  setup = function(use)
    require("plugins.editing._comment").setup(use)
    require("plugins.editing._highlight").setup(use)
    require("plugins.editing._nvim-autopairs").setup(use)
    require("plugins.editing._textobj").setup(use)
    require("plugins.editing._textobj-variable-segment").setup(use)
    require("plugins.editing._vim-strip-trailing-whitespace").setup(use)
    require("plugins.editing._pretty-fold").setup(use)
    require("plugins.editing._nvim-scrollbar").setup(use)
  end,
}
