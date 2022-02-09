local function config()
  require("neogen").setup {
    enabled = true,
  }

  require("which-key").register({
    c = {
      name = "Annotate",
      n = { ":lua require('neogen').generate()<CR>", "Annotate" },
    },
  }, { prefix = "<leader>" })
end

return {
  setup = function(use)
    use {
      "danymat/neogen",
      requires = { "nvim-treesitter/nvim-treesitter" },
      after = "which-key.nvim",
      config = config,
    }
  end,
}
