return {
  "akinsho/nvim-bufferline.lua",
  event = "VeryLazy",
  branch = "main",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim"
  },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<Cmd>BufferlineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<Cmd>BufferlineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferlineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  priority = 1000,
  opts = function()
    local theme = require "util".opts "catppuccin"

    return {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = { "", "" },
        indicator = { style = "underline", },
        close_command = function(n) require "mini.bufremove".delete(n, false) end,
        right_mouse_command = function(n) require "mini.bufremove".delete(n, false) end,
        diagnostics_indicator = function(_, _, diag)
          local s = " "
          for e, n in pairs(diag) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            s = s .. n .. " " .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "EXPLORER",
            text_align = "center",
            separator = vim.tbl_contains(theme.background_clear or {}, "neo-tree"), -- set to `true` if clear background of neo-tree
          },
        },
        hover = {
          enabled = true,
          delay = 0,
          reveal = { "close" },
        }
      }
    }
  end
}
