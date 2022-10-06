local function config()
  require("neo-tree").setup {
    close_if_last_window = true,
  }

  vim.keymap.set("n", "\\", function()
    require("neo-tree").reveal_current_file("filesystem", true, "<bang>" == "!")
  end, { noremap = true, silent = true, desc = "File Explorer" })
end

return {
  setup = function(use)
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = config,
    }
  end,
}
