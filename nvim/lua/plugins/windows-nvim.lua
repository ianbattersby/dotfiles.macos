local M = {
  "anuvyklack/windows.nvim",
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

  vim.keymap.set(
    { "n", "i" },
    "<C-W>z",
    "<CMD>WindowsMaximize<CR>",
    { silent = true, noremap = true, desc = "Maximize" }
  )

  vim.keymap.set(
    { "n", "i" },
    "<C-W>p",
    "<CMD>WindowsMaximizeHorizontally<CR>",
    { silent = true, noremap = true, desc = "Maximize Horizontally" }
  )

  vim.keymap.set(
    { "n", "i" },
    "<C-W>o",
    "<CMD>WindowsMaximizeVertically<CR>",
    { silent = true, noremap = true, desc = "Maximize Vertically" }
  )

  vim.keymap.set(
    { "n", "i" },
    "<C-W>e",
    "<CMD>WindowsEqualize<CR>",
    { silent = true, noremap = true, desc = "Equalize" }
  )
end

return M
