local M = {}

M.diagnostic_config = {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  virtual_lines = { only_current_line = true },
}

M.diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = { "Error", " " },
  [vim.diagnostic.severity.WARN] = { "Warn", " " },
  [vim.diagnostic.severity.INFO] = { "Info", " " },
  [vim.diagnostic.severity.HINT] = { "Hint", " " },
}

function M.setup()
  vim.diagnostic.config(M.diagnostic_config)

  vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticWarn" })

  for _, properties in pairs(M.diagnostic_signs) do
    local hl = "DiagnosticSign" .. properties[1]
    vim.fn.sign_define(hl, { text = properties[2], texthl = hl, numhl = "" })
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, M.diagnostic_config)
end

return M
