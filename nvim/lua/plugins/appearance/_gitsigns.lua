local function config()
  require("gitsigns").setup {
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
  }
end

return {
  setup = function(use)
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = config,
    }
  end,
}
