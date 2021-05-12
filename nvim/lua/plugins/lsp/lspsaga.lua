local function config()
  require('lspsaga').init_lsp_saga{
    code_action_keys = {
      quit = "<escape>"
    },
  }

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent=true }

  -- lsp provider to find the cursor word definition and reference
  map('n', 'gh', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
  -- code action
  map('n', '<a-cr>', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
  -- show hover doc
  map('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
  -- scroll down hover doc or scroll in definition preview
  map('n', 'C-f', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
  -- scroll up hover doc
  map('n', 'C-b', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-01)<CR>', opts)
  -- show signature help
  map('n', 'gs', '<cmd>lua require("lspsaga.lspsaga.signaturehelp").signature_help()<CR>', opts)
  -- rename
  map('n', 'gr', '<cmd>lua require("lspsaga.lspsaga.rename").rename()<CR>', opts)
  -- view definition
  map('n', 'gd', '<cmd>lua require("lspsaga.provider").preview_definition()<CR>', opts)
  -- show diagnostics
  map('n', 'cd', '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)
  -- show diagnostics only if cursor over the area
  map('n', 'cc', '<cmd>lua require("lspsaga.diagnostic").show_cursor_diagnostics()<CR>', opts)
  -- jump diagnostic
  map('n', '[e', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', opts)
  map('n', ']e', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', opts)
  -- float terminal
  map('n', 'A-d', '<cmd>lua require("lspsaga.lspsaga.floaterm").open_float_terminal()<CR>', opts)
  map('t', 'A-d', '<C-\\><C-n>:<cmd>lua require("lspsaga.lspsaga.floaterm").close_float_terminal()<CR>', opts)
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
