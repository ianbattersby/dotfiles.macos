return {
  setup = function()
    vim.fn.sign_define("LightBulbSign", { text = "", texthl = "DiagnosticWarn" })

    local diagnostic_signs = {
      [vim.diagnostic.severity.ERROR] = { "Error", " " },
      [vim.diagnostic.severity.WARN] = { "Warn", " " },
      [vim.diagnostic.severity.INFO] = { "Info", " " },
      [vim.diagnostic.severity.HINT] = { "Hint", " " },
    }

    for _, properties in pairs(diagnostic_signs) do
      local hl = "DiagnosticSign" .. properties[1]
      vim.fn.sign_define(hl, { text = properties[2], texthl = hl, numhl = "" })
    end
  end,
}
