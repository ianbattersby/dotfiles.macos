local function config()
  require("navigator").setup {}
end

return {
  setup = function(use)
    use {
      "ray-x/navigator.lua",
      requires = {
        { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
      },
      after = { "nvim-treesitter", "nvim-cmp" },
      run = ":lua vim.ui.select=guihua.gui.select()",
      config = config,
    }
  end,
}
