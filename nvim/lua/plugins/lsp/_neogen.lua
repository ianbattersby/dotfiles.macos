local function config()
  require("neogen").setup {
    enabled = true,
  }

  vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
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
