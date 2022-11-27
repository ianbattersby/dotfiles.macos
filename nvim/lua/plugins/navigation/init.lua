return {
  setup = function(use)
    require("plugins.navigation._numb").setup(use)
    require("plugins.navigation._neo-tree-nvim").setup(use)
    --require("plugins.navigation._neoconf-nvim").setup(use)
    require("plugins.navigation._telescope").setup(use)
    require("plugins.navigation._whichkey").setup(use)
    require("plugins.navigation._neogit").setup(use)
    require("plugins.navigation._help-vsplit").setup(use)
    require("plugins.navigation._session-manager").setup(use)
  end,
}
