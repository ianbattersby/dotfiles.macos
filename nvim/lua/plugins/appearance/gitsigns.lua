local function config()
  require('gitsigns').setup()
end

return {
  setup = function(use)
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = config
    }
  end
}
