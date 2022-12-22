local M = {}

M.diagnostic_config = {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  virtual_lines = { only_current_line = true },
}

function M.setup()
  vim.diagnostic.config(M.diagnostic_config)

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, M.diagnostic_config)
end

return M
