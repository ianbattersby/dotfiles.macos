local M = {
  "akinsho/nvim-bufferline.lua",
  branch = "main",
  dependencies = "kyazdani42/nvim-web-devicons",
}

function M.config()
  require("nvim-web-devicons").setup {
    default = true,
  }
  require("bufferline").setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
      separator_style = "thin",
      numbers = "buffer_id",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end,
    },
  }
end

return M
