local function config()
  --local map = vim.api.nvim_set_keymap
  --local opts = { noremap = true, silent=true }

  vim.g["vimspector_enable_mappings"] = 'HUMAN'

  --map('n', '<leader>vl', '', opts)
  --map('n', '<leader>vr', '', opts)
  --map('n', '<leader>ve', '', opts)
  --map('n', '<leader>vw', '', opts)
  --map('n', '<leader>vo', '', opts)
  --map('n', '<leader>vi', '', opts)
  --map('x', '<leader>vi', '', opts)


  vim.cmd[[nmap <leader>vl :call vimspector#Launch()<CR>]]
  vim.cmd[[nmap <leader>vr :VimspectorReset<CR>]]
  vim.cmd[[nmap <leader>ve :VimspectorEval]]
  vim.cmd[[nmap <leader>vw :VimspectorWatch]]
  vim.cmd[[nmap <leader>vo :VimspectorShowOutput]]
  vim.cmd[[nmap <leader>vi <Plug>VimspectorBalloonEval]]
  vim.cmd[[xmap <leader>vi <Plug>VimspectorBalloonEval]]

  vim.g['vimspector_install_gadgets'] = { 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' }
end

return {
  setup = function(use)
    use {
      'puremourning/vimspector',
      config = config
    }
  end
}
