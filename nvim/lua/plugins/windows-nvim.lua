local M = {
  "anuvyklack/windows.nvim",
  keys = {
    { "<C-W>z", "<CMD>WindowsMaximize<CR>", mode = { "n", "i" }, desc = "Maximize" },
    { "<C-W>p", "<CMD>WindowsMaximizeHorizontally<CR>", mode = { "n", "i" }, desc = "Maximize Horizontally" },
    { "<C-W>o", "<CMD>WindowsMaximizeVertically<CR>", mode = { "n", "i" }, desc = "Maximize Vertically" },
    { "<C-W>e", "<CMD>WindowsEqualize<CR>", mode = { "n", "i" }, desc = "Equalize" }
  },
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
}

function M.config()
  vim.o.winwidth = 10
  vim.o.winminwidth = 10
  vim.o.equalalways = false

  require("windows").setup {
    ignore = {
      buftype = {
        "nofile",
        "prompt",
        "popup",
        "nowrite",
      },
      filetype = {
        "DiffviewFiles",
        "DiffviewFileHistory",
        "DiffviewFilePanel",
        "fterm",
        "term",
        "toggleterm",
        "Trouble",
        "neo-tree",
      },
    },
    animation = {
      enable = true,
      duration = 300,
      fps = 30,
      easing = "in_out_sine",
    },
  }
end

return M
