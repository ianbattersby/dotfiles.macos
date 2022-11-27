local function config()
  require("Comment").setup {
    ignore = "^$",
    mappings = {
      basic = true,
      extra = true,
    },
  }
end

return {
  setup = function(use)
    use {
      "numToStr/Comment.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      config = config,
    }
  end,
}
