local function config()
end

return {
  setup = function(use)
    use {
      'mhinz/vim-startify',
      config = config
    }
  end
}
