local M = {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
    "DiffviewFocusFiles",
    "DiffviewToggleFiles",
    "DiffviewRefresh",
    "DiffviewLog",
  },
  keys = {
    {
      "<leader>wv",
      function()
        local lib = require "diffview.lib"
        local last_tabpage = vim.api.nvim_get_current_tabpage()
        local view = lib.get_current_view()
        if view then
          vim.api.nvim_set_current_tabpage(last_tabpage)
        else
          last_tabpage = vim.api.nvim_get_current_tabpage()
          if #lib.views > 0 then
            -- An open Diffview exists: go to that one.
            vim.api.nvim_set_current_tabpage(lib.views[1].tabpage)
          else
            -- No open Diffview exists: Open a new one
            vim.cmd ":DiffviewOpen"
          end
        end
      end,
      desc = "Diff View"
    },
  },
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  require "diffview".setup {
    icons = { -- Only applies when use_icons is true.
      folder_closed = "",
      folder_open = "",
    },
    signs = {
      fold_closed = "",
      fold_open = "",
    },
  }
end

return M
