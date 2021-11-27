local name = "onedark"

local function config()
  require('onedark').setup({
--     transparent = true,
--     colors = {
--       bg = "#8c6642",
--     }
  })
end

return {
  name = name,
  setup = function(use)
    use {
      'monsonjeremy/onedark.nvim',
      config = config
    }
  end
}
