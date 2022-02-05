local name = "onedark"

local function config()
  require("onedark").setup {
    sidebars = { "terminal", "telescope", "packer", "trouble", "NvimTree", "alpha", "Outline" },
  }
end

return {
  name = name,
  setup = function(use)
    use {
      "monsonjeremy/onedark.nvim",
      config = config,
      run = ":colorscheme onedark",
    }
  end,
}
