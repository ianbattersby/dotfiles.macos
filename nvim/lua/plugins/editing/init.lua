return {
  setup = function(use)
    require("plugins.editing._comment").setup(use)
    require("plugins.editing._nvim-autopairs").setup(use)
    require("plugins.editing._nvim-surround").setup(use)
    require("plugins.editing._textobj").setup(use)
    require("plugins.editing._nvim-ufo").setup(use)
    require("plugins.editing._nvim-hlslens").setup(use)
    require("plugins.editing._diffview").setup(use)
  end,
}
