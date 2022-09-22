local name = "onedark"

local function config()
  require("onedark").setup {
    sidebars = { "terminal", "telescope", "packer", "trouble", "NvimTree", "alpha", "Outline", "DiffviewFiles", "mind" },
    --dark_float = true,
  }
end

return {
  name = name,
  setup = function(use)
    use {
      "ful1e5/onedark.nvim",
      config = config,
      run = ":colorscheme onedark",
    }
  end,
}
