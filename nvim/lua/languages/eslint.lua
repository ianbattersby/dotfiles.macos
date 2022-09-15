local config = {
  enable = true,
  format = { enable = true }, -- this will enable formatting
  packageManager = "npm",
  autoFixOnSave = true,
  codeActionsOnSave = {
    mode = "all",
    rules = { "!debugger", "!no-only-tests/*" },
  },
  lintTask = {
    enable = true,
  },
}

local function finalize()
  --vim.cmd [[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]]
end

return { server = "eslint", config = config, finalize = finalize }
