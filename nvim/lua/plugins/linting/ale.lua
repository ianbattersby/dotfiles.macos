return {
  setup = function(use)
    use {
      'dense-analysis/ale',
      ft = { 'cmake', 'javascript', 'markdown', 'bash', 'sh', 'html', 'vim' },
      cmd = 'ALEEnable',
      config = 'vim.cmd[[ALEEnable]]'
    }
  end
}
