return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "\\",
      function()
        require "neo-tree.command".execute({ toggle = true, position = "left", dir = require "util".root() })
      end,
      desc = "File Explorer"
    },
    {
      "<leader>fe",
      function()
        require "neo-tree.command".execute({ toggle = true, position = "float", dir = require "util".root() })
      end,
      desc = "File Explorer (root dir)",
    },
    {
      "<leader>fE",
      function()
        require "neo-tree.command".execute({ toggle = true, dir = require "util".root() })
      end,
      desc = "File Explorer (cwd)",
    },
    opts = require "config.neo-tree",
  },
}
