return {
  setup = function(use)
      require'plugins.appearance.theme'.setup(use)
      require'plugins.appearance.lualine'.setup(use)
      require'plugins.appearance.gitsigns'.setup(use)
      require'plugins.appearance.bufferline'.setup(use)
      require'plugins.appearance.startify'.setup(use)
      require'plugins.appearance.floaterm'.setup(use)
  end
}
