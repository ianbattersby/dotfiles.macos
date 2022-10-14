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
        {
          -- only needed if you want to use the commands with "_with_window_picker" suffix
          "s1n7ax/nvim-window-picker",
          tag = "v1.*",
          config = function()
            require("window-picker").setup {
              use_winbar = "smart",
              autoselect_one = true,
              include_current = false,
              filter_rules = {
                bo = {
                  filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },
                  buftype = { "terminal" },
                },
              },
              other_win_hl_color = "#e35e4f",
            }
          end,
        },
      },
      config = config,
    }
  end,
}
