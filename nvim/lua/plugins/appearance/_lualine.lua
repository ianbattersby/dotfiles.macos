local function config()
  local navic = require "nvim-navic"
  local components = require "plugins.appearance._lualine_components"

  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = require("plugins.appearance._theme").name,
      componentseparators = { "", "" },
      section_separators = { "", "" },
      --extensions = { "fzf" },
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
        "mind",
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "b:gitsigns_head", icon = "" }, "diff" },
      lualine_c = {
        { components.progress_or_filename, path = 1, file_status = true },
        {
          navic.get_location,
          cond = navic.is_available,
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
          require("noice").api.statusline.command.get,
          cond = require("noice").api.statusline.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.statusline.mode.get,
          cond = require("noice").api.statusline.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.statusline.search.get,
          cond = require("noice").api.statusline.search.has,
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

return {
  setup = function(use)
    use {
      "hoob3rt/lualine.nvim",
      requires = {
        { "kyazdani42/nvim-web-devicons" },
        { "nvim-lua/lsp-status.nvim" },
      },
      after = { "nvim-navic" },
      config = config,
    }
  end,
}
