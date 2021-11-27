local function config()
  require('Comment').setup()
end

return {
  setup = function(use)
    use {
      'numToStr/Comment.nvim',
      config = config
    }
  end
}
