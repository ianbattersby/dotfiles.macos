local function config()
  require("Comment").setup {
    ignore = "^$",
    mappings = {
      basic = true,
      extra = true,
      extended = true,
    },
  }
end

return {
  setup = function(use)
    use {
      "numToStr/Comment.nvim",
      after = "nvim-treesitter",
      config = config,
    }
  end,
}
