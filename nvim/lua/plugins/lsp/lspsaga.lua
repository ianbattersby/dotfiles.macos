local function config()
  require('lspsaga').init_lsp_saga{
    code_action_keys = {
      quit = "<escape>"
    },
  }
  local map = vim.api.nvim_set_keymap
  local options = { noremap = true }
  map('n', '<a-cr>', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', options)
end

return {
  setup = function(use)
    use {
      'glepnir/lspsaga.nvim',
      branch = 'main',
      config = config
    }
  end
}
