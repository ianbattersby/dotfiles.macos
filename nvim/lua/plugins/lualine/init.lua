local M = {
  "hoob3rt/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/noice.nvim",
    "SmiteshP/nvim-navic",
  },
}

function M.config()
  local navic = require "nvim-navic"
  local components = require "plugins.lualine.components"

  require "lualine".setup {
    options = {
      icons_enabled = true,
      theme = "catppuccin",
      componentseparators = { "", "" },
      section_separators = { "", "" },
      extensions = { "lazy", "neo-tree", "nvim-dap-ui", "toggleterm", "trouble" },
      disabled_filetypes = {
        "alpha",
        "packer",
        "Trouble",
        "Outline",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "DiffviewFiles",
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "b:gitsigns_head", icon = "" }, "diff" },
      lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        {
          navic.get_location,
          cond = navic.is_available,
        },
        {
          require "noice".api.statusline.command.get,
          cond = require "noice".api.statusline.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          require "noice".api.statusline.mode.get,
          cond = require "noice".api.statusline.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require "noice".api.statusline.search.get,
          cond = require "noice".api.statusline.search.has,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_x = {
        "encoding",
        "fileformat",
        "filetype",
        -- {
        --   require("noice").api.status.message.get_hl,
        --   cond = require("noice").api.status.message.has,
        -- },
        {
          require "noice".api.statusline.command.get,
          cond = require "noice".api.statusline.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          require "noice".api.statusline.mode.get,
          cond = require "noice".api.statusline.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require "noice".api.statusline.search.get,
          cond = require "noice".api.statusline.search.has,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_y = { { components.diagnostics } }, --"progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return M
