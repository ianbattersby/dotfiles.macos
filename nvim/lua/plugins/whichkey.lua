local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "g", group = "+goto" },
        { "gz", group = "+surround" },
        { "]", group = "+next" },
        { "[", group = "+prev" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "debug" },
        { "<leader>da", group = "adapters" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>sn", group = "noice" },
        { "<leader>t", group = "test" },
        { "<leader>u", group = "ui" },
        { "<leader>w", group = "windows" },
        { "<leader>x", group = "diagnostics/quickfix" },
      },
    },
  },
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
  end,
}

return M
