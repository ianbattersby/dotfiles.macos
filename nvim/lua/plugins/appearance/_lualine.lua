local function config()
  local gps = require "nvim-gps"
  local components = require "plugins.appearance._lualine_components"

  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = require("plugins.appearance._theme").name,
      componentseparators = { "", "" },
      section_separators = { "", "" },
      extensions = { "fzf" },
      disabled_filetypes = { "alpha", "NvimTree", "packer", "Trouble" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "b:gitsigns_head", icon = "" }, "diff" },
      lualine_c = {
        { components.progress_or_filename, path = 0, file_status = true },
        {
          gps.get_location,
          cond = function()
            return package.loaded["nvim-treesitter"] ~= nil and gps.is_available()
          end,
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
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
      requires = { { "kyazdani42/nvim-web-devicons", opt = true }, { "nvim-lua/lsp-status.nvim", opt = false } },
      after = { "onedark.nvim" },
      config = config,
    }
  end,
}
