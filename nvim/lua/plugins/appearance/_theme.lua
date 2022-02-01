local name = "onedark"

local function config()
  require("onedark").setup {
    sidebars = { "terminal", "telescope", "packer", "trouble", "NvimTree", "alpha" },
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
