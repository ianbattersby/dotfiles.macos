return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
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
  },
  opts = require "config.neo-tree",
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require "neo-tree"
        vim.cmd [[set showtabline=0]]
      end
    end
  end,
}
