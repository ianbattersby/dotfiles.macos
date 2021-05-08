return {
  setup = function(use)
    use {
      'dense-analysis/ale',
      ft = { 'cmake', 'javascript', 'markdown' },
      cmd = 'ALEEnable',
      config = 'vim.cmd[[ALEEnable]]'
    }
  end
}
