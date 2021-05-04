local name = "gruvbox"

local function config()
end

return {
  name = name,
  setup = function(use)
    use {
      'morhetz/gruvbox',
      config = config
    }
  end
}
