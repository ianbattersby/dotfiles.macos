local function config()
  require("neogen").setup {
    enabled = true,
  }

  vim.keymap.set("n", "<leader>cn", function()
    require("neogen").generate()
  end, { noremap = true, silent = true, desc = "Annotate" })
end

return {
  setup = function(use)
    use {
      "danymat/neogen",
      requires = { "nvim-treesitter/nvim-treesitter" },
      config = config,
    }
  end,
}
