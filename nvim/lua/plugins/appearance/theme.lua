local name = "onedark"

local function config()
  require('onedark').setup()
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
