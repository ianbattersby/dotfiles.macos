local function config()
  require("alpha").setup(require("alpha.themes.startify").opts)

  vim.keymap.set("n", "<leader>a", "<CMD>Alpha<CR>", { noremap = true, silent = true, desc = "Startup" })
end

return {
  setup = function(use)
    use {
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = config,
    }
  end,
}
