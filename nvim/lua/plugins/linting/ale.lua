return {
  setup = function(use)
    use {
      'w0rp/ale',
      ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
      cmd = 'ALEEnable',
      config = 'vim.cmd[[ALEEnable]]'
    }
  end
}
