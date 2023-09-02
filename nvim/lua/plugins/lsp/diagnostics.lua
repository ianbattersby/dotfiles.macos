local M = {}

M.diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = { "Error", " " },
  [vim.diagnostic.severity.WARN] = { "Warn", " " },
  [vim.diagnostic.severity.INFO] = { "Info", " " },
  [vim.diagnostic.severity.HINT] = { "Hint", " " },
}

M.virtual_text = {
  spacing = 4,
  source = "if_many",
  prefix = function(diagnostic)
    return M.diagnostic_signs[diagnostic.severity][2]
  end,
}

M.virtual_lines = {
  only_current_line = false,
  highlight_whole_line = false,
}

M.config_diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  severity_sort = true,
  signs = true,
  virtual_lines = false,
}

function M.setup()
  vim.diagnostic.config(M.config_diagnostics)

  vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticWarn" })

  for _, properties in pairs(M.diagnostic_signs) do
    local hl = "DiagnosticSign" .. properties[1]
    vim.fn.sign_define(hl, { text = properties[2], texthl = hl, numhl = "", icon = properties[2] })
  end

  -- vim.lsp.handlers["textDocument/publishDiagnostics"] =
  --   vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, require "util".diagnostic_config())
end

return M
