local M = {
  "akinsho/nvim-bufferline.lua",
  event = "VeryLazy",
  branch = "main",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim"
  },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  priority = 1000,
  opts = {
    -- stylua: ignore
    close_command = function(n) require "mini.bufremove".delete(n, false) end,
    -- stylua: ignore
    right_mouse_command = function(n) require "mini.bufremove".delete(n, false) end,
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      local s = " "
      for e, n in pairs(diag) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
  config = function(_, opts)
    require "bufferline".setup {
      highlights = require "catppuccin.groups.integrations.bufferline".get(),
      options = opts
    }
  end,
}

return M
