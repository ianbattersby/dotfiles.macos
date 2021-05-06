local function config()
end

return {
  setup = function(use)
    use {
      'neoclide/coc.nvim',
      branch = release,
      run = ":CocInstall coc-html coc-yank coc-eslint",
      config = config
    }
  end
}
