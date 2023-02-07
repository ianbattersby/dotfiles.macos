local M = {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "\\", function() require "neo-tree".reveal_current_file("filesystem", true, "<bang>" == "!") end,
      desc = "File Explorer" },
  },
  cmd = "Neotree",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    { "s1n7ax/nvim-window-picker", version = "v1.5" },
  },
}

function M.config()
  require "window-picker".setup {
    use_winbar = "smart",
    autoselect_one = true,
    include_current = false,
    filter_rules = {
      bo = {
        filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix", "neotest-summary" },
        buftype = { "terminal" },
      },
    },
    other_win_hl_color = "#e35e4f",
  }

  require "neo-tree".setup {
    close_if_last_window = true,
  }
end

return M
